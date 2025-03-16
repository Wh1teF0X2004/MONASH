class Product {
	constructor(name, cost, quantity) {
		this.name = name;
		this.cost = cost;
		this.quantity = quantity;
		this.image = "/product.jpg";
		this.id = Math.round(Math.random() * 1000);
	}
}

module.exports = Product;
