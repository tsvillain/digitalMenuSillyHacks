const mongoose = require('mongoose');

const shopSchema = new mongoose.Schema({
	userID: {
		type: mongoose.Schema.ObjectId,
		ref: 'User',
		require: true
	},
	shopName: {
		type: String,
		required: true
	},
	// => ===
	shopStartTime: Date,
	shopEndTime: Date,
	shopType: {
		type: String,
		enum: ['veg', 'non-veg', 'veg & non-veg both'],
		default: 'veg',
		require: true
	},
	menu: [
		{
			category: String,
			name: String,
			price: Number
		}
	],
	public: {
		type: Boolean,
		default: false
	}
});

const Shop = mongoose.model('Shop', shopSchema);

module.exports = Shop;
