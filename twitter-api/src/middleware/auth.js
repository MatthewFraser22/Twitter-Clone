const jwt = require('jsonwebtoken')
const User = require('../models/user')

const Auth = async (req, res, next) => { // what does next mean ? it is middleware it allows to move on to the next step only when we want to.
    try {
        const token = req.header('Authorization').replace('Bearer ', '')
        const decoded = jwt.verify(token, 'twittertoken')

        const user = await User.findOne({ _id: decoded._id, 'tokens.token': token})

        if (!user) {
            throw new Error('User doesnt exist')
        }

        req.token = token
        req.user = user
        next()
    } catch (err) {
        res.status(401).send({ error: 'Please authenticate' })
    }
}

module.exports = Auth