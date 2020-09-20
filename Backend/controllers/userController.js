const { promisify } = require('util');
const jwt = require('jsonwebtoken');
const User = require('./../models/userModel');
const Shop = require('./../models/shopModel');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');

exports.signup = catchAsync(async (req, res, next) => {
	const newUser = await User.create({
		name: req.body.name,
		email: req.body.email,
		password: req.body.password
	});

	res.status(201).json({
		status: 'success',
		message: 'User Created Succesfully'
	});
});

exports.login = catchAsync(async (req, res, next) => {
	const { email, password } = req.body;

	if (!email || !password) {
		return next(new AppError('Please provide email and password', 400));
	}

	const user = await User.findOne({ email }).select('+password');

	if (!user) {
		return next(new AppError('Their is no user with this email', 404));
	}

	if (!(await user.correctPassword(password, user.password))) {
		return next(new AppError('Incorrect email or password.', 401));
	}

	const shopData = await Shop.findOne({ userID: user._id });

	const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
		expiresIn: process.env.JWT_EXPIRES_IN
	});

	user.password = undefined;

	res.status(200).json({
		status: 'success',
		token,
		data: shopData ? { userData: user, shopData } : { userData: user, shopData: null }
	});
});

exports.protect = catchAsync(async (req, res, next) => {
	let token;

	if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
		token = req.headers.authorization.split(' ')[1];
	}

	if (!token) {
		return next(new AppError('You are not logged in! Please logg in to acees', 401));
	}

	const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);

	const currentUser = await User.findById(decoded.id);
	if (!currentUser) {
		return next(new AppError('The user beloging to this token does no longer exist.', 401));
	}

	req.user = currentUser;
	next();
});
