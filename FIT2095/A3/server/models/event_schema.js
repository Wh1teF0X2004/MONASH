/**
 * @author Euan Lim 33045984 <elim0062@student.monash.edu>
 * Represents a Mongoose Schema for Event class
 */

/**
 * Import required package to reference the Mongoose package to create your schema:
 */
const mongoose = require("mongoose");

/**
 * Generates a random category ID 
 *
 * @function
 * @returns {string} A random ID 
 */
function createId() {
  const allCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const allNumbers = '0123456789';

  let randomCharacters = '';
  let randomNumbers = '';

  for (let i = 0; i < 2; i++) { // Change 3 to 2 for characters
      randomCharacters += allCharacters[Math.floor(Math.random() * allCharacters.length)];
  }

  for (let i = 0; i < 4; i++) {
      randomNumbers += allNumbers[Math.floor(Math.random() * allNumbers.length)];
  }

  const randomNewID = `E${randomCharacters}-${randomNumbers}`;
  return randomNewID;
}

/**
 * Mongoose Schema for an event
 *
 * @property {string} id - Unique ID of the event
 * @property {string} name - Name of the event
 * @property {string} description - The events description
 * @property {Date} startDateTime - The start date and time of the event.
 * @property {number} durationInMinutes - The duration of the event in minutes.
 * @property {number} capacity - The capacity of the event
 * @property {number} ticketsAvailable - The number of available tickets (defaulted to capacity)
 * @property {Array<string>} categoryList - An array of category IDs associated with the event
 * @property {Date} createdAt - The date and time when the event was created
 * @property {boolean} isActive - Indicates if the event is active (true by default)
 */
const eventSchema = mongoose.Schema({
    id: {
      type: String,
      unique: true,
      default: createId,
    },
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    startDateTime: {
      type: Date,
      required: true,
    },
    durationInMinutes: {
      type: Number,
      required: true,
    },
    capacity: {
      type: Number,
      required: true,
      validate: {
        validator: function (value) {
          return value >= 10 && value <= 2000;
        },
        message: "Capacity must be between 10 and 2000 (inclusive).",
      },
    },
    ticketsAvailable: {
        type: Number,
        default: function () {
          return this.capacity; // Use a function to set default based on capacity
        },
    },
    categoryList: {
      type: [String],
      required: true,
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    isActive: {
      type: Boolean,
      default: true, // Set isActive to true by default
    },
    imagePath: {
        type: String,
    }
});

module.exports = mongoose.model("Event", eventSchema);