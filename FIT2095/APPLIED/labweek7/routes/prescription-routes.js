const express = require("express");
const prescriptionCont = require("../controllers/prescription-controller");

const router = express.Router();

router.post("/", prescriptionCont.createPrescription);
router.get("/", prescriptionCont.getAll);
router.put("/", prescriptionCont.addMedicine);

module.exports = router;