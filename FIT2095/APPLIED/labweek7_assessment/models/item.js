const mongoose = require("mongoose");

const itemSchema = mongoose.Schema({
	name: {
		type: String,
		required: true,
        default: "UNNAMED",
	},
	quantity: {
		type: Number,
		validate: {
			validator: function (value) {
				return value >=1 && value <= 100;
			},
			message: "Quantity must be between 0 and 100",
		},
	},
    cost : {
        type: Number,
        validate: {
			validator: function (value) {
				return value > 0;
			},
			message: "Cost must be positive number",
		},
    }
});

module.exports = mongoose.model("Item", itemSchema);