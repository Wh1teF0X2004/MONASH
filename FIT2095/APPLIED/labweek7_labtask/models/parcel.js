const mongoose = require('mongoose');

const parcelSchema = new mongoose.Schema({
  sender: { type: mongoose.Schema.Types.ObjectId, ref: 'Sender' },
  weight: Number,
  address: String,
  fragile: Boolean,
});

module.exports = mongoose.model('Parcel', parcelSchema);
