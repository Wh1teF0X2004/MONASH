const print = console.log;
async function add_1(i) {
	i = i + 1;
	print("add_1 executed");
	return i;
}

async function add_2(i) {
	i = i + 2;
	print("add_2 executed");
	return i;
}
async function add_3(i) {
	i = i + 3;
	print("add_3 executed");

	return i;
}

add_1(4).then(add_2).then(add_3).then(print);

// Promise-->then()
// Promise-->catch()
