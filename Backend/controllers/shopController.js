const Shop = require('../models/shopModel');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');

exports.getAllShop = catchAsync(async (req, res, next) => {
  const data = await Shop.find({ public: true });

  // Check Guard
  if (data.length === 0) {
    return next(new AppError('Their is no data in the database', 404));
  }

  res.status(200).json({
    status: 'success',
    length: data.length,
    data
  });
});

exports.getshopByToken = catchAsync(async (req, res, next) => {
  const data = await Shop.findOne({ userID: req.user._id });

  // Check Guard
  if (!data) {
    return next(new AppError('Their is no data in the database', 404));
  }

  res.status(200).json({
    status: 'success',
    data
  });
});

exports.createShop = catchAsync(async (req, res, next) => {
  // Check Guard
  if (!req.body.shopName) return next(new AppError('shopName is mandatory field!', 404));
  if (!req.body.menu) return next(new AppError('menu is mandatory field!', 404));

  const check = await Shop.findOne({ userID: req.user._id });
  if (check) return next(new AppError('Shop Already have a menu card', 404));

  req.body.userID = req.user._id;
  const data = await Shop.create(req.body);

  res.status(201).json({
    status: 'success',
    data
  });
});

exports.getSingleShop = catchAsync(async (req, res, next) => {
  // Check Guard
  if (!req.params.id) {
    return next(new AppError('ID in params is mandatory.', 404));
  }

  const data = await Shop.findOne({ _id: req.params.id });

  // Check Guard
  if (!data) {
    return next(new AppError('Their is no data with this id', 404));
  }

  res.status(200).json({
    status: 'success',
    data: data
  });
});

exports.updateSingelShop = catchAsync(async (req, res, next) => {
  // Check Guard
  if (!req.params.id || !req.body) {
    return next(new AppError('ID in params or Data in body is mandatory ', 404));
  }

  const data = await Shop.findOneAndUpdate({ _id: req.params.id }, req.body, { new: true });

  res.status(200).json({
    status: 'success',
    data: data
  });
});

exports.deleteSingleShop = catchAsync(async (req, res, next) => {
  // Check Guard
  if (!req.params.id) {
    return next(new AppError('ID in params is mandatory ', 404));
  }

  await Shop.findOneAndDelete({ _id: req.params.id });

  res.status(200).json({
    status: 'success',
    message: 'Shop is deleted'
  });
});
