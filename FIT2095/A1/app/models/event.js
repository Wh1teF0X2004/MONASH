/**
 * Represents an event instance of the system
 * @class
 */
class Event {
    /**
     * default image path for events
     * @type {string}
     * @static
     */
    static DEFAULT_IMAGE_PATH = "cabbage_logo.jpg"

    /**
     * default active state for events
     * @type {boolean}
     * @static
     */
    static DEFAULT_ACTIVE_STATE = true

    /**
     * default capacity for events
     * @type {number}
     * @static
     */
    static DEFAULT_CAPACITY = 1000

    /**
     * Creates an instance of Event
     * @constructor
     * @param {string} name - The name of the event
     * @param {string} description - The description of the event
     * @param {Date} startDateTime - The start date and time of the event
     * @param {number} duration - The duration of the event in minutes
     * @param {boolean} [isActive=true] - Whether the event is active
     * @param {string} [imagePath=Event.DEFAULT_IMAGE_PATH] - The image path for the event
     * @param {number} [capacity=Event.DEFAULT_CAPACITY] - The capacity of the event
     * @param {number} [ticketsAvailable] - The number of tickets available
     * @param {string} categoryId - The ID of the event category
     */
    constructor(name, description, startDateTime, duration, isActive, imagePath, capacity, ticketsAvailable, categoryId) {
        this.id = this.generateId()
        this.name = name                       
        this.description = description
        this.startDateTime = startDateTime
        this.duration = duration
        this.isActive = isActive !== undefined && isActive !== '' ? isActive : Event.DEFAULT_ACTIVE_STATE
        this.imagePath = imagePath !== undefined && imagePath !== '' ? imagePath: Event.DEFAULT_IMAGE_PATH
        this.capacity = capacity !== undefined && capacity !== '' ? capacity : Event.DEFAULT_CAPACITY
        this.ticketsAvailable = ticketsAvailable ? ticketsAvailable : this.capacity
        this.categoryId = categoryId
    }   
    
    /**
     * generates random id in format of E{rand char}{rand char}-{rand 4 didgits}
     * @private
     * @returns {string} The generated id
     */
    generateId() {
        const CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        
        let randomChar1 = CHARACTERS[Math.floor(Math.random() * CHARACTERS.length)]
        let randomChar2 = CHARACTERS[Math.floor(Math.random() * CHARACTERS.length)]
        let randomDigits = Math.floor(Math.random() * 10000).toString().padStart(4, '0')
        
        return `E${randomChar1}${randomChar2}-${randomDigits}`
    }
}

module.exports = Event