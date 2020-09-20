const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config({ path: './config.env' });
const app = require('./app');

const DB = process.env.DATABASE;
const PORT = process.env.PORT || 3000;

mongoose
	.connect(DB, {
		useNewUrlParser: true,
		useCreateIndex: true,
		useFindAndModify: false,
		useUnifiedTopology: true
	})
	.then(() => console.log('DB connections succesfull'))
	.catch((err) => console.log('ERROR'));

const server = app.listen(PORT, () => {
	console.log(`Server Is started at port ${process.env.PORT || 5000}`);
});
