const express = require('express');
require('./db/mongoose')
const userRouter = require('./routers/user')
const tweetRouter = require('./routers/tweet')
const notificationRouter = require('./routers/notification')

const app = express();

const port = process.env.port || 3000; // port is either comming from environment variables or its 3000

app.use(express.json())
app.use(userRouter)
app.use(tweetRouter)
app.use(notificationRouter)

app.listen(port, () => {
    console.log("The server is up on the port " + port);
})