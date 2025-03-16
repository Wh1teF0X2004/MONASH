/**
 * @author Euan Lim 33045984 <elim0062@student.monash.edu>
 * Controller methods for managing events
 */

/**
 * Required Packages from event and category are imported
 */
const Category = require("../models/category_schema");
const Event = require("../models/event_schema");
const Operation = require('../models/operation_schema');

module.exports = {

    /**
     * creates a new event
     *
     * @param {Object} req - express req object
     * @param {Object} res - express response
     */
    newEvent: async function (req, res) {
        try {
            let name = req.body.name;
            let description = req.body.description;
            let startDateTime = req.body.startDateTime;
            let durationInMinutes = req.body.duration;
            let isActive = req.body.isActive;
            let imagePath = req.body.imagePath;
            let capacity = req.body.capacity;
            let ticketsAvailable = req.body.tickets ? req.body.tickets : capacity;
            let categoryList = req.body.categoryList.split(',').map((category) => category.trim());

            const newEvent = new Event({
                name,
                description,
                startDateTime,
                durationInMinutes,
                capacity,
                ticketsAvailable,
                categoryList,
                isActive,
                imagePath,
            });

            await newEvent.save();

            for (const categoryId of categoryList) {
                const category = await Category.findOne({ id: categoryId });
                if (category) {
                    category.eventsList.push(newEvent.id);
                    await category.save();
                }
            }

            const counters = await Operation.findOne({});
            counters.addCount += 1;
            await counters.save();

            res.status(200).json(newEvent.id);
        } catch (error) {
            return res.status(404).json({ "status": "Invalid Fields" });
        }
    },

    /**
     * getAllEvent: Get all events
     */
    getAllEvent: async function (req, res){
        let event = await Event.find({});
        res.status(200).json(event);
    },

    /**
     * deleting an event by its id
     *
     * @param {Object} req - express req object
     * @param {Object} res - express response
     */
    deleteEvent: async function (req, res) {
        try {
            const event = await Event.findOne({ "id": req.body.eventId });
            if (!event) {
                return res.status(404).json({"acknowledged": false, "deletedCount": 0 });
            }

            const categories = event.categoryList;
            await Event.deleteOne({"id": req.body.eventId});

            for (const categoryId of categories) {
                const category = await Category.findOne({ id: categoryId });
                if (category) {
                    category.eventsList = category.eventsList.filter((eventIdInList) => eventIdInList !== req.body.eventId);
                    await category.save();
                }
            }

            const counters = await Operation.findOne({});
            counters.deleteCount += 1;
            await counters.save();

            res.status(200).json({
                "acknowledged": true,
                "deletedCount": 1
            });
        } catch (error) {
            return res.status(404).json({"acknowledged": false, "deletedCount": 0 });
        }
    },

    /**
     * updating events name and capacity
     *
     * @param {Object} req - express req object
     * @param {Object} res - express response
     */
    updateEvent: async function (req, res) {
        console.log("REACH")
        console.log(req.body)
        try {
            const eventId = req.body.eventId;
            const newName = req.body.newName;
            const newCapacity = Number(req.body.newCapacity);

            if (newCapacity > 2000 || newCapacity < 10) {
                return res.status(404).json({ "status": "Invalid Capacity amount" });
            }

            const event = await Event.findOne({ "id": eventId });

            if (!event) {
                return res.status(404).json({ "status": "Event not found" });
            }

            event.name = newName;
            event.capacity = newCapacity;

            const counters = await Operation.findOne({});
            counters.updateCount += 1;
            await counters.save();

            await event.save();
            return res.status(200).json({ "status": "Updated successfully" });
        } catch (error) {
            return res.status(404).json({ "status": "Event likely not found" });
        }
    },
};