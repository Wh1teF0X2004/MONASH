const mongoose = require("mongoose");

const prescriptionSchema = mongoose.Schema({
	name: String,
	medicines: [
		{
			type: mongoose.Schema.Types.ObjectId,
			ref: "Medicine",
		},
	],
});

module.exports = mongoose.model("Prescription", prescriptionSchema);