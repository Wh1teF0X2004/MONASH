/**
 * @author Foo Kai Yan 33085625 <kfoo0012@student.monash.edu>
 * Represents a Mongoose Schema for Category class
 */

/**
 * Import required package to reference the Mongoose package to create your schema:
 */
const mongoose = require("mongoose");

/**
 * Function to check if a string is alphanumeric
 *
 * @function
 * @param {string} value - The string to be checked
 * @returns {boolean} - `true` if the input string is alphanumeric, `false` otherwise
 */
function isAlphaNumeric(value) {
    for (let i = 0; i < value.length; i++) {
        const char = value[i];
        if (!((char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9'))) {
            return false;
        }
    }
    return true;
}

/**
 * Generates a random category ID
 *
 * @function
 * @returns {string} A random ID in the format 'C<2 random letters>-<4 random numbers>'
 */
function createId(){
    const allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const allNumbers = '0123456789';

    let randomLetters = allLetters[Math.floor(Math.random() * allLetters.length)] + allLetters[Math.floor(Math.random() * allLetters.length)];
    let randomNumbers = allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)];

    const randomNewID = `C${randomLetters}-${randomNumbers}`;
    return randomNewID;
}

/**
 * Mongoose Schema for a category.
 *
 * @property {string} name - The name of the category. Must be alphanumeric
 * @property {string} description - The description of the category
 * @property {string} image - The image path associated with the category
 * @property {string} id - The unique ID of the category
 * @property {Date} createdAt - The date and time when the category was created
 * @property {Array<String>} eventsList - An array of events reference
 */
const categorySchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        default: "New Category",
        validate: {
            validator: isAlphaNumeric,
            message: "Name must only contain alphanumeric characters :DDD"
        }
    },
    description:{
        type: String
    },
    image: {
        type: String, 
        default: "/category_page.jpg" 
    },
    id: {
        type: String,
        unique: true, // Make sure the IDs are unique
        default: createId // Set the default value to the result of createId function
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    eventsList:[{
        type: String, 
        ref: "Event"
    }]
});

/**
 * The Category model represents a category in the database
 *
 * @name Category
 * @exports Category
 */
module.exports = mongoose.model("Category", categorySchema);