// Importing Express
const express = require("express")
const router = express.Router()

/**
 * Default title for the page.
 * @type {string}
 * @constant
 */
const PAGE_TITLE = "Cabbage EMA";

/**
 * Default iamge for favcon
 * @type {string}
 * @constant
 */
const PAGE_FAVICON = "cabbagefav.jpg";

/** Route for the Index Page */
router.get("/", (req, res) => {
  // Render the EJS template with the dynamic title
  res.render("index", { title: PAGE_TITLE, favicon: PAGE_FAVICON });
})

module.exports = router