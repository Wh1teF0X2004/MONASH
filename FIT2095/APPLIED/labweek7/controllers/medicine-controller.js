const Medicine = require("../models/medicine");
module.exports = {
	createMedicine: async function (req, res) {
		let aMedicine = new Medicine({ name: req.body.name, dose: parseInt(req.body.dose) });
		await aMedicine.save();
		res.status(200).json(aMedicine);
	},
	getAll: async function (req, res) {
		let medicine = await Medicine.find({});
		res.status(200).json(medicine);
	},
	deleteById: async function (req, res) {
		let id = req.body.id;
		let obj = await Medicine.deleteOne({ _id: id });
		res.json(obj);
	},
};
