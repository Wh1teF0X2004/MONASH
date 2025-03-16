const express = require('express');
const router = express.Router();
const senderController = require('../controllers/senderController');

// Task 1: Get all parcels from a sender
router.get('/:senderName', senderController.getAllParcelsFromSender);

// Task 1: Create a new sender
router.post('/', senderController.createSender);

// Task 1: Delete sender by ID
router.delete('/:senderId', senderController.deleteSenderById);

// Task 1: Update sender's name by ID
router.put('/:senderId', senderController.updateSenderNameById);

module.exports = router;
