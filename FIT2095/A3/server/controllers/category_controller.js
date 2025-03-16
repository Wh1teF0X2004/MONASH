/**
 * @author Foo Kai Yan 33085625 <kfoo0012@student.monash.edu>
 * Controller methods for managing categories
 */

/**
 * Required Packages from event and category are imported
 */
const Category = require("../models/category_schema");
const Event = require("../models/event_schema");
const Operation = require('../models/operation_schema');

/**
 * newCategory: Create a new category
 * getAllCategory: Get all category
 * deleteCategoryById: Delete specific category by unique category ID
 * updateCategory: Update specific category's name and description by category ID
 */
module.exports = {
    /**
     * newCategory: Create a new category
     * @function
     * @async
     * @param {Object} req - Express request object
     * @param {Object} res - Express response object
     * @returns {void}
     */
    newCategory: async function (req, res){
        let newCat = "";
        console.log(req.body.image);
        if (req.body.image === ""){
            newCat = new Category({
                name: req.body.name,
                description: req.body.description
            });
        } else {
            newCat = new Category({
                name: req.body.name,
                description: req.body.description,
                image: req.body.image
            });
        }

        const counters = await Operation.findOne({});
        counters.addCount += 1;
        await counters.save();

        await newCat.save();
        res.status(200).json(newCat.id);
    },

    /**
     * getAllCategory: Get all categories
     * @function
     * @async
     * @param {Object} req - Express request object.
     * @param {Object} res - Express response object.
     * @returns {void}
     */
    getAllCategory: async function (req, res){
        let category = await Category.find({});
        res.status(200).json(category);
    },

    /**
     * deleteCategoryById: Delete a specific category by its unique category ID and the events under it
     * @function
     * @async
     * @param {Object} req - Express request object.
     * @param {Object} res - Express response object.
     * @returns {void}
     */
    deleteCategoryById: async function (req, res){
        let categoryId = req.body.id;

        const events = (await Category.findOne({"id": categoryId})).eventsList;

        // Get category event list and delete all the events in the event list with deleteOne
        let theCategory = await Category.findOne({ id: categoryId });

        for (const eventId of events) {
          const event = await Event.findOne({ id: eventId });
          if (event) {
            event.categoryList = event.categoryList.filter((eventIdInList) => eventIdInList !== eventId);
            // theCategory.eventsList.pop(eventId);
            await event.save();
          }
        }

        // Get the event list from theCategory
        const eventList = theCategory.eventsList;

        // Delete all events in the event list
        for (let i = 0; i < theCategory.eventsList.length; i++) {
            const eventId = theCategory.eventsList[i].id;
            await Event.deleteOne({ id: eventId });
        }
        
        let categoryObj = await Category.deleteOne({ id: categoryId }); 

        const counters = await Operation.findOne({});
        counters.deleteCount += 1;
        await counters.save();

		res.json(categoryObj);
    },

    /**
     * updateCategory: Update a specific category's name and description by category ID
     * @function
     * @async
     * @param {Object} req - Express request object.
     * @param {Object} res - Express response object.
     * @returns {void}
     */
    updateCategory: async function (req, res){
        const id = req.body.id;
        
        const name = req.body.name;
        const description = req.body.description;

        const result = await Category.updateOne({ "id": id }, { $set: {"name": name, "description": description} });

        const counters = await Operation.findOne({});
        if (counters) {
        counters.updateCount += 1;
        await counters.save();
        }

        if (result.nModified === 0) {
            // ID not found
            res.status(404).json({ "status": "ID not found" });
        } else {
            res.status(200).json(result);
        }
    }
};