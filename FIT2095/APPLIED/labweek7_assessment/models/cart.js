const mongoose = require("mongoose");

const cartSchema = mongoose.Schema({
  name: {
    type: String,
    default: "CART",
  },
  address: {
    type: String,
    required: true,
  },
  items: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Item",
    },
  ],
});

module.exports = mongoose.model("Cart", cartSchema);
