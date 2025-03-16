// labweek8_assessment

const { relative } = require("path");
const Weather = require("../models/weather_schema");

module.exports = {
	newWeather: async function (req, res) {
        const newWeather = new Weather({
            temp: parseInt(req.body.temp),
            humidity: parseInt(req.body.humidity),
            wind: parseInt(req.body.wind),
            rain: parseInt(req.body.rain),
            status: req.body.status,
            thunderstorm: req.body.thunderstorm,
        });

        const validationError = newWeather.validateSync();
        if (validationError) {
            res.status(404).json({ error: validationError.message });
        } else {
            await newWeather.save();
            res.status(200).json(newWeather);
        }
	},
    getWeather: async function (req, res) {
		let weather = await Weather.find({});
		res.status(200).json(weather);
	},
	deleteWeatherByTemp: async function (req, res) {
		let filter = {temp: {$lt: req.body.temp}};
        let result = await Weather.deleteMany(filter);
        res.json(result)
	},
    updateWeather: async function (req, res) {
        const id = req.body.id;
        
        const humidity = parseInt(req.body.humidity);
        const rain = parseInt(req.body.rain);
        const status = req.body.status;

        const result = await Weather.updateOne({ "_id": id }, { $set: {"humidity": humidity, "rain": rain, "status": status} });
        res.status(200).json(result);
	},
};
