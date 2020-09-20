const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
	name: {
		type: String,
		required: true
	},
	email: {
		type: String,
		required: true,
		unique: true
	},
	password: {
		type: String,
		required: true,
		select: false
	}
});

// This function runs when password field is Modified
userSchema.pre('save', async function(next) {
	if (!this.isModified('password')) return next();

	// Hash the password
	this.password = await bcrypt.hash(this.password, 12);
	next();
});

// When user update his password
userSchema.pre('save', function(next) {
	if (!this.isModified('password') || this.isNew) return next();
});

// Function to compare password
userSchema.methods.correctPassword = async function(candidatePassword, userPassword) {
	return await bcrypt.compare(candidatePassword, userPassword);
};

const User = mongoose.model('User', userSchema);

module.exports = User;
