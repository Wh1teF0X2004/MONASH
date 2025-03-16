/**
 * @author Foo Kai Yan 33085625 <kfoo0012@student.monash.edu>
 * Configuring RESTFul Endpoints to manage categories
 */

/**
 * Required Packages from event and category are imported
 */
const express = require("express");
const categoryCont = require("../controllers/category_controller");

const router = express.Router();

/**
 * Configuring RESTFul Endpoints to create a new category
 */
router.post("/", categoryCont.newCategory);

/**
 * Configuring RESTFul Endpoints to get all category
 */
router.get("/", categoryCont.getAllCategory);

/**
 * Configuring RESTFul Endpoints to delete specific category by unique category ID
 */
router.delete("/", categoryCont.deleteCategoryById);

/**
 * Configuring RESTFul Endpoints to update specific category's name and description by category ID
 */
router.put("/", categoryCont.updateCategory);

/**
 * Exported Express Router
 * 
 * @module router
 * @description This module exports an instance of the Express Router, which is used to define routes and middleware for an Express.js application
 * @returns {object} An instance of the Express Router
 */
module.exports = router;