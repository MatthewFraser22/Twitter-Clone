const express = require('express')
const { findById } = require('../models/user')
const User = require('../models/user')

const router = new express.Router()

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
module.exports = router