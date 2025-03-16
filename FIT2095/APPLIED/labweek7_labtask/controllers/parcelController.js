const Parcel = require('../models/parcel');

module.exports = {
  addParcelToSender: async function (req, res) {
    try {
      const { senderId, weight, address, fragile } = req.body;
      const parcel = new Parcel({ sender: senderId, weight, address, fragile });
      await parcel.save();
      res.status(200).json(parcel);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },

  getAllParcelsByAddress: async function (req, res) {
    const { address } = req.query;
    try {
      const parcels = await Parcel.find({ address });
      res.status(200).json(parcels);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },

  updateParcelAddressById: async function (req, res) {
    try {
      const { address } = req.body;
      const parcel = await Parcel.findByIdAndUpdate(req.params.parcelId, { address }, { new: true });
      if (!parcel) {
        return res.status(404).json({ message: 'Parcel not found' });
      }
      res.json(parcel);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  },
};
