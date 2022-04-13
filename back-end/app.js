require('dotenv').config({ path: `./config/${process.env.NODE_ENV}.env` })

const express = require('express');

const app = express();

const cors = require('cors');
app.use(cors())

app.use(express.json());

const usersRoute = require('./routes/router');

app.use('/api', usersRoute);

app.get('/api', (_, res) => res.send("Hello from API v1"));

app.listen(5500, () => console.log(`Back end is running on PORT ${5500}`));

module.exports = app;
