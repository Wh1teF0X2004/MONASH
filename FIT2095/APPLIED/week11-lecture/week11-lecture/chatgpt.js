const { OpenAI } = require("openai");

const openai = new OpenAI({
	apiKey: "your-openai-key-here",
});

async function askChatGPT() {
	let result = await openai.chat.completions.create({
		model: "gpt-3.5-turbo",
		messages: [
			{
				role: "user",
				content: "Write a Java code to sort an array of 10 integers",
			},
		],
	});
	console.log(result.choices[0].message);
}

askChatGPT();
