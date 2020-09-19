const router = require('express').Router();
const userController = require('./../controllers/userController');
const shopController = require('./../controllers/shopController');

router
	.route('/')
	.get(shopController.getAllShop)
	.post(userController.protect, shopController.createShop);

router.route('/shopByToken').get(userController.protect, shopController.getshopByToken);

router
	.route('/:id')
	.get(shopController.getSingleShop)
	.patch(userController.protect, shopController.updateSingelShop)
	.delete(userController.protect, shopController.deleteSingleShop);

module.exports = router;
