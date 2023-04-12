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

module.exports = router