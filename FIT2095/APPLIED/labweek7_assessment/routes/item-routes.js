const express = require("express");
const itemCont = require("../controller/item-controller");

const router = express.Router();

router.post("/", itemCont.newItem); 
router.delete("/", itemCont.deleteById);
router.get("/", itemCont.getAll);

module.exports = router;


