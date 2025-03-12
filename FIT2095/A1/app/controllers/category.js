// Importing Express
const express = require("express")
const router = express.Router()
const path = require("path");
const Category = require("../models/event_category");

router.use(express.json());
router.use(express.static("node_modules/bootstrap/dist/css"));
router.use(express.static(path.join(__dirname, "../public/images")));

// Constant for Page Title
const PAGE_TITLE = "Cabbage EMA";
const PAGE_FAVICON = "cabbagefav.jpg";
const PAGE_BANNER = "cabbage_app_banner.jpg";
const DEFAULT_IMAGE_PATH = "../images/cabbage_logo.jpg";

// Constant for category folder
const CATEGORY_FILE_ROUTES = "category/";

// Constant for server
const eventManager = require("./event_manager");
console.log(eventManager.eventCategories)

router.get("/", (req, res) => {
  res.send("Hello from category!")
})

/***
 * Routes for the CATEGORY functionality
*/

/** Route for adding a new category */
router.get("/add", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(CATEGORY_FILE_ROUTES + "add_category", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER });
})

router.post("/add", (req, res) => {
  console.log(req.body)
  let name = req.body.name
  let description = req.body.description
  let image = req.body.image 
  
  console.log(req.body.name)
  console.log(req.body.description)
  console.log(req.body.image)

  let newCategory = new Category(name, description, image);
  eventManager.eventCategories.push(newCategory);

  res.redirect("/33085625/category/list")
})

/** Route for deleting a category by id */
router.get("/delete", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(CATEGORY_FILE_ROUTES + "delete_category", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER });
})

router.post("/delete", (req, res) => {
  console.log(req.body.id)
  let id = req.body.id
  let index = eventManager.eventCategories.findIndex(event => event.id.toString() === id.toString())

  if (index !== -1) {
    eventManager.eventCategories.splice(index, 1)
  }
  res.redirect("/33085625/category/list")
})

router.get("/list", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render(CATEGORY_FILE_ROUTES + "list_category", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, categoryArray: eventManager.eventCategories });
  res.redirect("/33085625/category/list");
})

/** Route for viewing all category by keyword*/
router.get("/keyword", (req, res) => {
  let keyword_array = [];
  let keyword = req.query.keyword;
  console.log(keyword);

  if (keyword === "Undefined"){
    console.log("KEYWORD UNDEFINED BRUH");
    res.render(CATEGORY_FILE_ROUTES + "list_keyword_category", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, keyword: "", categoryArray: eventManager.eventCategories });
    res.redirect("/33085625/category/list");
  } else {

    const matchNo = function(one, two) {
      const keywords = one.toLowerCase().match(/\w+/g);
      
      for (let i = 0; i < keywords.length; i++) {
          if (two.toLowerCase().includes(keywords[i])) {
              return true;
          }
      }
      
      return false;
    };
  
    for (let i=0; i<eventManager.eventCategories.length; i++){
      if (matchNo(keyword, eventManager.eventCategories[i].description)){
        keyword_array.push(eventManager.eventCategories[i]);
      }
      console.log(keyword_array);
      res.render(CATEGORY_FILE_ROUTES + "list_keyword_category", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, keyword: keyword, categoryArray: keyword_array });
      res.redirect("/33085625/category/list");
    }
  }
})

/** Route for viewing all event details*/
router.get("/detail", (req, res) => {
  const id = req.query.id; 
  let event_detail;
  
  for (let i = 0; i < eventManager.events.length; i++) {
    if (eventManager.events[i].id === id) {
      event_detail = eventManager.events[i];
      break; 
    }
  }

  // Render the EJS template with the dynamic title
  res.render(CATEGORY_FILE_ROUTES + "event_detail", { title: PAGE_TITLE, favicon: PAGE_FAVICON, banner: PAGE_BANNER, event_detail: event_detail });
})

module.exports = router
