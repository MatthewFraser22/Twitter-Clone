const mongoose = require('mongoose')

const notificationSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true
    },
    notifiSenderId: {
        type: mongoose.Schema.Types.ObjectId, // connect to another mongoose schema the User schema
        required: true,
        ref: 'User' // connecting to the user model
    },
    notifiRecieverId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    notificationType: {
        type: String
    },
    postText: {
        type: String
    }
})

const Notification = mongoose.model('Notification', notificationSchema)

module.exports = Notification