const express = require('express');

require('./db/mongoose')

const app = express();

const port = process.env.port || 3000; // port is either comming from environment variables or its 3000

app.listen(port, () => {
    console.log("The server is up on the port " + port);
})