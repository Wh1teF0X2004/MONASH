const { Translate } = require("@google-cloud/translate").v2;

const translate = new Translate();

const theText = "Good morning, its week 11";
const targetLanguage = "zh";

async function translateMyText(text, target) {
	let translation = await translate.translate(text, target);
	console.log(translation);
}

translateMyText(theText, targetLanguage);
