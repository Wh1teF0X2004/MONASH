/**
 * @author Euan Lim 33045984 <elim0062@student.monash.edu>
 * Configuring RESTFul Endpoints to manage Events
 */

const express = require("express");
const eventCont = require("../controllers/event_controller");

const router = express.Router();

// http://localhost:5000/api/v1/event/euan
router.post("/", eventCont.newEvent);
router.get("/", eventCont.getAllEvent);
router.delete("/", eventCont.deleteEvent);
router.put("/", eventCont.updateEvent);

module.exports = router;