const Prescription = require("../models/prescription");
const Medicine = require("../models/medicine");

module.exports = {
	createPrescription: async function (req, res) {
		let aPrescription = new Prescription({ name: req.body.name });
		await aPrescription.save();
		res.json(aPrescription);
	},
	getAll: async function (req, res) {
		let Prescriptions = await Prescription.find().populate("medicines");
		res.json(Prescriptions);
	},
	addMedicine: async function (req, res) {
		let medicineId = req.body.medicineId;
		let prescriptionId = req.body.prescriptionId;
		let theMedicine = await Medicine.findOne({ _id: medicineId });
		let thePrescription = await Prescription.findOne({ _id: prescriptionId });
		thePrescription.medicines.push(theMedicine._id);
		await thePrescription.save();
		res.redirect("/pres");
	},
};