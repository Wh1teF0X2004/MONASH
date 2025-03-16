const Cart = require("../models/cart");
const Item = require("../models/item");

module.exports = {
	newCart: async function (req, res) {
		let aCart = new Cart({ name: req.body.name, address: req.body.address });
		await aCart.save();
		res.json(aCart);
	},
	addItem: async function (req, res) {
        let itemId = req.body.itemId;
		let cartId = req.body.cartId;

		let theItem = await Item.findOne({ _id: itemId });
		let theCart = await Cart.findOne({ _id: cartId });
        
		theCart.items.push(theItem);
        
		await theCart.save();
		res.json(theCart);
	},
    deleteItem: async function (req, res) {
        let itemId = req.body.itemId;
		let cartId = req.body.cartId;

		let theItem = await Item.findOne({ _id: itemId });
		let theCart = await Cart.findOne({ _id: cartId });
        
		theCart.items.pop(theItem);

        await theCart.save();
        res.redirect("/cart");
	},
    getAll: async function (req, res) {
		let aCart = await Cart.find().populate("items");
		res.json(aCart);
	},
};