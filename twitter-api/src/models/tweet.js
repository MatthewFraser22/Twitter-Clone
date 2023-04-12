const mongoose = require('mongoose');

const tweetSchema = new mongoose.Schema({
    text: {
        type: String,
        required: true,
        trim: true
    },
    user: {
        type: String,
        required: true
    },
    username: {
        type: String,
        required: true,
        trim: true
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // reference id comes from user object
        required: true,

    },
    image: {
        type: Buffer // method to store data of image in server
    },
    likes: {
        type: Array,
        default: []
    }
}, {
    timestamps: true
})

tweetSchema.methods.toJSON = function() {
    const tweet = this

    const tweetObject = tweet.toObject()

    if (tweetObject.image) {
        tweetObject.image = "true"
    }

    return tweetObject
}

const Tweet = mongoose.model('Tweet', tweetSchema)

module.exports = Tweet