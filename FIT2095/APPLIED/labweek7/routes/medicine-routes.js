const express = require("express");
const medicineCont = require("../controllers/medicine-controller");

const router = express.Router();

router.post("/", medicineCont.createMedicine);
router.get("/", medicineCont.getAll);
router.delete("/", medicineCont.deleteById);

module.exports = router;