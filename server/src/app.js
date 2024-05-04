const express = require("express");
const cors = require('cors'); // Import the cors module
require("./db/mongoose");
const taskRouter = require("./routers/taskRouter");
const userRouter = require("./routers/userRouter");

const app = express();

// Enable CORS for all routes
app.use(cors()); // Enable CORS for all routes
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    next();
  });

app.use(express.json());
app.use(taskRouter);
app.use(userRouter);

module.exports = app
