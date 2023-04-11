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
})

module.exports = router