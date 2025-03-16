const express = require('express');
const mongoose = require('mongoose');
const senderRouter = require('./routers/senderRouter');
const parcelRouter = require('./routers/parcelRouter');

const app = express();

// Connect to MongoDB (replace 'mongodb://localhost/your-database' with your MongoDB URL)
mongoose.connect('mongodb://localhost/your-database', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Middleware for parsing JSON
app.use(express.json());

// Use the routers for Sender and Parcel
app.use('/sender', senderRouter);
app.use('/parcel', parcelRouter);

// Start the server on port 8080
const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
