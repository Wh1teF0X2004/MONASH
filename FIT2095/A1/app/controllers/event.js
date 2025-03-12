// Importing Express
const express = require("express")
const router = express.Router()
const path = require("path")
const Event = require("../models/event");

// Middleware
router.use(express.static("node_modules/bootstrap/dist/css"))
router.use(express.static(path.join(__dirname, "../public/images")))
router.use(express.json())

/**
 * Default title for the page.
 * @type {string}
 * @constant
 */
const PAGE_TITLE = "Cabbage EMA"

/**
 * Default Favicon.
 * @type {string}
 * @constant
 */
const PAGE_FAVICON = "cabbagefav.jpg"

/**
 * Default banner for page
 * @type {string}
 * @constant
 */
const PAGE_BANNER = "cabbage_app_banner.jpg"

/**
 * Default event route
 * @type {string}
 * @constant
 */
const EVENT_FILE_ROUTES = "event/"

/**
 * Server Database 
 * @type {string}
 * @constant
 */
const eventManager = require("./event_manager");

router.get("/", (req, res) => {
  res.send("Hello from event!")
})

/***
 * Routes for the EVENT functionality
*/

/** Route for adding an event */
router.post("/add", (req, res) => {
  let name = req.body.name
  let description = req.body.description
  let startDateTime = req.body.startDateTime
  let duration = req.body.duration
  let isActive = req.body.isActive
  let imagePath = req.body.imagePath
  let capacity = req.body.capacity
  let ticketsAvailable = req.body.tickets
  let categoryId = req.body.categoryId
  
  // Required values
  if (name != undefined && startDateTime != undefined && duration != undefined && categoryId != undefined ) {
    let isValidCategoryId = eventManager.eventCategories.some(category => category.id === categoryId);

    if (isValidCategoryId) {
      let newEvent = new Event(name, description, startDateTime, duration, isActive, imagePath, capacity, ticketsAvailable, categoryId);
      eventManager.events.push(newEvent);
      return res.redirect("/euan/event/list");
    }
  }
  res.redirect("/euan/event/add")
})

/** Route for removing and event by id via query */
router.get("/remove", (req, res) => {
  if (req.query.id != undefined) {
    let id = req.query.id
    let index = eventManager.events.findIndex(event => event.id.toString() === id.toString())
  
    if (index !== -1) {
      eventManager.events.splice(index, 1)
    }
  } 
  // Always redirect to list
  res.redirect("/euan/event/list")
})

/** Route for removing and event by id via post */
router.post("/remove", (req, res) => {
  console.log(req.body)
  if (req.body.eventId != undefined) {
    let id = req.body.eventId
    let index = eventManager.events.findIndex(event => event.id.toString() === id.toString())
    if (index !== -1) {
      eventManager.events.splice(index, 1)
    }
    res.redirect("/euan/event/list")
  } 
})

/** Route for adding a new event */
router.get("/add", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(EVENT_FILE_ROUTES + "add_event", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, route: "/euan/event/add"})
})

/** Route for deleting a event by id */
router.get("/delete", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(EVENT_FILE_ROUTES + "delete_event", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER,  route: "/euan/event/remove"})
})

/** Route for viewing all the events */
router.get("/list", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(EVENT_FILE_ROUTES + "list_event", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, db: eventManager.events })
})

/** Route for viewing all the sold-out events */
router.get("/sold", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(EVENT_FILE_ROUTES + "sold_event", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, db: eventManager.events })
})

/** Route for viewing all category details */
router.get("/detail/:id", (req, res) => {
  const id = req.params.id
  let category_detail = null // Initialize to null

  for (let i = 0; i < eventManager.eventCategories.length; i++) {
    if (eventManager.eventCategories[i].id.toString() === id.toString()) {
      category_detail = eventManager.eventCategories[i]
      break
    }
  }
  
  // Render the EJS template with the dynamic title
  res.render(EVENT_FILE_ROUTES + "category_detail", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, category: category_detail, db: eventManager.events })
})

module.exports = router