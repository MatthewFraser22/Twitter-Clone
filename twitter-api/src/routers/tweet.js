const express = require('express')
const multer = require('multer')
const sharp = require('sharp')
const Tweet = require('../models/tweet')

const router = new express.Router()

const auth = require('../middleware/auth')

// HELPER FUNCTIONS

const upload = multer({
    limits: {
        fileSize: 100000000
    }
})

// ENDPOINTS

// UPLOAD IMAGE TO TWEET ROUTE
router.post('/uploadTweetImage/:id', auth, upload.single('upload'), async (req, res) => {
    const tweet = await Tweet.findOne({ _id: req.params.id })
    console.log(tweet)

    if (!tweet) {
        throw new Error('Cannot find the tweet')
    }

    const buffer = await sharp(req.file.buffer).resize( { width: 350, height: 350 } ).png().toBuffer()

    tweet.image = buffer
    await tweet.save()
    
    res.send()
}, (error, req, res, next) => { // can do this because we are using middle ware
    res.status(400).send( { error: error.message } )
})

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