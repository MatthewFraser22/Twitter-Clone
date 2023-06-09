const mongoose  = require('mongoose')
const validator = require('validator')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    username: {
        type: String,
        required: true,
        trim: true,
        unique: true
    },
    email: {
        type: String,
        unique: true,
        required: true,
        trim: true,
        lowercase: true,
        validate(value) {
            if (!validator.isEmail(value)) {
                throw new Error('Invalid email')
            }
        }
    },
    password: {
        type: String,
        required: true,
        minLength: 7,
        trim: true,
        validate(value) {
            if (value.toLowerCase().includes('password')) {
                throw new Error('Password cannot contain "password"')
            }
        }
    },
    tokens: [{
        token: {
            type: String,
            required: true
        }
    }],
    avatar: {
        type: Buffer,
    },
    avatarExists: {
        type: Boolean
    },
    bio: {
        type: Boolean
    },
    website: {
        type: String
    },
    location: {
        type: String
    },
    followers: {
        type: Array,
        default: []
    },
    followings: {
        type: Array,
        default: []
    }
})

// Relationship between the Tweets and the user
userSchema.virtual('tweets', {
    ref: 'Tweet',
    localField: '_id',
    foreignField: 'user'
})

userSchema.virtual('notificationsSent', {
    ref: "Notification", // refers to notification model
    localField: '_id',
    foreignField: 'notifiSenderId' // feild name in the notification schema
})

userSchema.virtual('notificationsSent', {
    ref: "Notification",
    localField: '_id',
    foreignField: 'notifiReceiverId'
})

// Getting the JSON that would be sent to the client and deleting the password
// delete password prior to GET request
userSchema.methods.toJSON = function() {
    const user = this
    const userObject = user.toObject();

    delete userObject.password

    return userObject
}

// Hash the password
// use pre to hash the password before saving in the DB
userSchema.pre('save', async function(next) {
    const user = this

    if (user.isModified('password')) {
        user.password = await bcrypt.hash(user.password, 8)
    }

    next()
})

// Create Tokens
userSchema.methods.generateAuthToken = async function () {
    const user = this

    const token = jwt.sign({ _id: user._id.toString() }, 'twittertoken') //jwt.sign returns a token
    user.tokens = user.tokens.concat({ token })

    await user.save()

    return token
}


// Authentication Check
userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({ email })

    if (!user) {
        throw new Error('Unable to login')
    }

    // check if password matches
    const isMatch = await bcrypt.compare(password, user.password)

    if (!isMatch) {
        throw new Error('Unable to login')
    }

    return user
}


const User = mongoose.model('User', userSchema)

module.exports = User