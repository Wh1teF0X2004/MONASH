const Item = require("../models/item");

module.exports = {
	newItem: async function (req, res) {
		let aItem = new Item({ name: req.body.name, quantity: parseInt(req.body.quantity), cost: parseFloat(req.body.cost)});
		await aItem.save();
		res.status(200).json(aItem);
	},
    getAll: async function (req, res) {
		let item = await Item.find({});
		res.status(200).json(item);
	},
	deleteById: async function (req, res) {
		let id = req.body.id;
		let obj = await Item.deleteOne({ _id: id });
		res.json(obj);
	},
};
