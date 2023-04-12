const express = require('express')
const Tweet = require('../models/tweet')

const router = new express.Router()

const auth = require('../middleware/auth')

// ENDPOINTS

// POST TWEET
router.post('/tweets', auth, async (req, res) => {
    const tweet = new Tweet({
        ...req.body,
        user: req.user._id
    })

    try {
        await tweet.save()
        res.send(201).send(tweet)
    } catch (err) {
        res.status(400).send(err)
    }
})

// GET ALL TWEETS
router.get('/tweets', async (req, res) => {
    try {
        const tweet = await Tweet.find({})
        res.status(201).send(tweet)
    } catch (err) {
        res.status(500).send(err)
    }
})

module.exports = router