const express = require('express');
const router = express.Router();
const parcelController = require('../controllers/parcelController');

// Task 2: Add Parcel to Sender
router.post('/', parcelController.addParcelToSender);

// Task 3: Get all Parcels by Address
router.get('/', parcelController.getAllParcelsByAddress);

// Task 3: Update Parcel Address by ID
router.put('/:parcelId', parcelController.updateParcelAddressById);

module.exports = router;
