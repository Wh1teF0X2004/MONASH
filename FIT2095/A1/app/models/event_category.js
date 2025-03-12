/**
 * Represents a category for the system
 */
class Category {
    /**
     * Default image path for categories, Category final variable
     * @type {string}
     * @static
     */
    static DEFAULT_IMAGE_PATH = "../images/cabbage_logo.jpg";

    /**
     * Creates a new Category instance
     * @param {string} name - The name of the category
     * @param {string} description - The description of the category
     * @param {string} [image] - The image path of the category, Defaults to "category_page.jpg"
     */
    constructor(name, description, image){
        this.name = name;
        this.description = description;
        this.image = image ? image: "category_page.jpg"; 
        this.id = this.createId();
        this.createdAt = this.dateCreated();
    }

    /**
     * generates a random category id
     * @returns {string} The generated category id
     * @private
     */
    createId(){
        const allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const allNumbers = '0123456789';

        let randomLetters = allLetters[Math.floor(Math.random() * allLetters.length)] + allLetters[Math.floor(Math.random() * allLetters.length)];
        let randomNumbers = allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)];

        const randomNewID = `C${randomLetters}-${randomNumbers}`;
        return randomNewID;
    }
    
    /**
     * creates and returns the date of the catergory
     * @returns {string} formatted date
     * @private
     */
    dateCreated(){
        var currentDate = new Date();
        var day = currentDate.getDate();
        var month = currentDate.getMonth() + 1; 
        var year = currentDate.getFullYear();
        var hours = currentDate.getHours();
        var minutes = currentDate.getMinutes();
        var seconds = currentDate.getSeconds();
        var amOrPm = hours >= 12 ? 'pm' : 'am';

        // Adjust hours for 12-hour format
        if (hours > 12) {
            hours -= 12;
        } else if (hours === 0) {
            hours = 12;
        }

        var formattedDate = `${day}/${month}/${year} ${hours}:${minutes}:${seconds} ${amOrPm}`;
        return formattedDate;
    }
}

module.exports = Category;