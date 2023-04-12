const express = require('express')
const auth = require('../middleware/auth')
const Notification = require('../models/notification')

const router = new express.Router();

router.post('/notification', auth, async (req, res) => {
    const notification = new Notification({
        ...req.body,
        user: req.user._id
    })

    try {
        await notification.save()
        res.status(201).send(notification)
    } catch (err) {
        res.status(400).send(err)
    }
})

router.get('/notification', async (req, res) => {
    try {
        const notifications = await Notification.find({})
        res.send(notifications)
    } catch (err) {
        res.status(500).send(err)
    }
})

// Fetch notifcation for specific user
router.get('/notification/:id', async (req, res) => {
    const _id = req.params.id

    try {
        const notifcations = await Notification.find({ notifiRecieverId: _id })
        res.send(notifcations)
    } catch (err) {
        res.status(500).send(err)
    }
})

module.exports = router