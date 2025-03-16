const express = require("express");
const cartCont = require("../controller/cart-controller");

const router = express.Router();

router.post("/", cartCont.newCart);
router.put("/", cartCont.addItem);
router.get("/", cartCont.getAll);
router.delete("/", cartCont.deleteItem);

module.exports = router;