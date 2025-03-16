// labweek8_assessment

const express = require("express");
const weatherCont = require("../controller/weather_controller");

const router = express.Router();

router.post("/", weatherCont.newWeather); 
router.delete("/", weatherCont.deleteWeatherByTemp);
router.get("/", weatherCont.getWeather);
router.put("/", weatherCont.updateWeather);

module.exports = router;


