const mongoose = require('mongoose');

const senderSchema = new mongoose.Schema({
  name: String,
  parcels: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Parcel' }],
});

module.exports = mongoose.model('Sender', senderSchema);
