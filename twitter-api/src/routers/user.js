const express = require('express')
const { findById } = require('../models/user')
const User = require('../models/user')
const multer = require('multer')
const sharp = require('sharp')
const auth = require('../middleware/auth')

const router = new express.Router()

// HELPERS

const upload = multer({
    limits: {
        fileSize: 100000000
    }
})

// ADD ENDPOINTS HERE

// CREATE USER ENDPOINT
router.post('/users', async (req, res) => {
    const user = new User(req.body)

    try {
        await user.save()

        res.status(201).send(user)
    } catch (err) {
        res.status(400).send(err)
    }
})

// GET ALL USERS ENDPOINT
router.get('/users', async (req, res) => {
    try {
        const users = await User.find({})
    
        res.send(users)
    } catch (err) {
        res.status(500).send(err)
    }
})

// LOGIN USER ENDPOINT
router.post('/users/login', async (req, res) => {
    try {
        const user = await User.findByCredentials(req.body.email, req.body.password)
        const token = await user.generateAuthToken()

        res.send({ user, token })
    } catch (err) {
        res.status(400).send(err)
    }
});

// DELETE USER
router.delete('/users/:id', async (req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id)

        if (!user) {
        return res.status(400).send()
        }

        res.send()
    } catch (err) {
        res.status(500).send(err)
    }
})

// FETCH A SPECIFIC USER
router.get('/users/:id', async (req, res) => {

    try {
        const user = await User.findById(req.params.id)

        if (!user) {
            return res.status(404).send()
        }

        res.status(201).send(user)
    } catch (err) {
        res.status(500).send(err)
    }
})

// POST USER PROFILE IMAGE
router.post('/users/me/avatar', auth, upload.single('avatar'), async (req, res) => { // asks for a file to be uplaoded by the user 'upload.single('avatar'), single fetches the image and uses as part of the request
    const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250}).png().toBuffer() // storing the code that makes up the png

    if (req.user.avatar != null) {
        req.user.avatar = null
        req.user.avatarExists = false
    }

    req.user.avatar = buffer
    req.user.avatarExists = true

    try {
        await req.user.save()
        res.send(buffer)
    } catch (err) {
        res.status(500).send({error: 'failed to save buffer'})
    }
    
}, (error, req, res, next) => {
    res.status(400).send({error: error.message})
})

// GET user avatar
router.get('/users/:id/avatar', async (req, res) => {
    try {
        const user = await User.findById(req.params.id)

        if (!user || !user.avatarExists) {
            throw new Error('User does not exist')
        }

        res.set('Content-Type', 'image/jpg')
        res.send(user.avatar)
    } catch (err) {
        res.status(404).send(err)
    }
})

// Route for following
router.put('/users/:id/follow', auth, async (req, res) => { // AUTH gives us access to req.user, Controls the header of our requests
    if (req.user.id != req.params.id) {
        // if id authenticated from auth is the same as the req.params (the url :id property)
        try {
            const user = await User.findById(req.params.id) // User we want to follow

            if (!user.followers.includes(req.user.id)) {
                await user.updateOne({ $push: { followers: req.user.id } })
                await req.user.updateOne({ $push: { followings: req.params.id }})

                res.status(200).json('User has been followed')
            } else {
                res.status(403).json('you already follow this user')
            }
        } catch (err) {
            res.status(500).json("failed to follow user " + err)
        }
    } else { // user is trying to follow themselves
        res.status(403).json('You cannot follow yourself')
    }
})

// UNFOLLOW USER
router.put('/users/:id/unfollow', auth, async (req, res) => {
    if (req.user.id != req.params.id) { // userid not equal to their own id
        const userToUnfollow = await User.findById(req.params.id)

        if (req.user.followings.includes(req.params.id)) {
            try {
                await userToUnfollow.updateOne( { $pull: { followers: req.user.id } } )
                await req.user.updateOne( { $pull: { followings: req.params.id } } )
    
                res.status(200).json('Successfully unfollowed')
            } catch (err) {
                res.status(500).json('failed to unfollow ' + err)
            }
        } else {
            res.status(403).json('You dont unfollow this user')
        }
    } else {
        res.status(403).json('you cannot unfollow yourself')
    }
})

module.exports = router