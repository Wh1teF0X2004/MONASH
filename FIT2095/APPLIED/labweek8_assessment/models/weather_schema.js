// labweek8_assessment

const mongoose = require("mongoose");

const weatherSchema = mongoose.Schema({
	temp: {
		type: Number,
		validate: {
			validator: function (value) {
				return value >= -5 && value <= 60;
			},
			message: "Temperature must be between -5 and 60",
		},
	},
	humidity: {
		type: Number,
		validate: {
			validator: function (value) {
				return value >= 0 && value <= 100;
			},
			message: "Humidity must be between 0 and 100",
		},
	},
    wind : {
        type: Number,
		validate: {
			validator: function (value) {
				return value >= 0 && value <= 50;
			},
			message: "Wind must be between 0 and 50",
		},
    },
    rain: {
		type: Number,
		validate: {
			validator: function (value) {
				return value >= 0 && value <= 10;
			},
			message: "Rain must be between 0 and 10",
		},
	},
    status: {
        type: String,
        enum: ["sunny", "rainy", "cloudy"],
    },
    thunderstorm: {
        type: Boolean,
        default: false, 
    },
    
});

module.exports = mongoose.model("Weather", weatherSchema);