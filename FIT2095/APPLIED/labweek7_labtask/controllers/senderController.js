const Sender = require('../models/sender');

module.exports = {
  createSender: async function (req, res) {
    try {
      const { name } = req.body;
      const sender = new Sender({ name });
      await sender.save();
      res.status(200).json(sender);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },
  
  getAllParcelsFromSender: async function (req, res) {
    try {
      const sender = await Sender.findOne({ name: req.params.senderName }).populate('parcels');
      if (!sender) {
        return res.status(404).json({ message: 'Sender not found' });
      }
      res.json(sender.parcels);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },

  deleteSenderById: async function (req, res) {
    try {
      const sender = await Sender.findByIdAndDelete(req.params.senderId);
      if (!sender) {
        return res.status(404).json({ message: 'Sender not found' });
      }
      res.json({ message: 'Sender deleted' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },

  updateSenderNameById: async function (req, res) {
    try {
      const { name } = req.body;
      const sender = await Sender.findByIdAndUpdate(req.params.senderId, { name }, { new: true });
      if (!sender) {
        return res.status(404).json({ message: 'Sender not found' });
      }
      res.json(sender);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },
};
