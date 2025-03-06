const mongoose = require("mongoose");

const VenueSchema = new mongoose.Schema({
  name: { type: String, required: true },
  location: { type: String, required: true },
  capacity: { type: Number, required: true },
  price: { type: Number, required: true },
  description: { type: String, required: true }, // New field for description
  images: [{ type: String, required: true }], // Array to store multiple image URLs
  available: { type: Boolean, default: true },
});

module.exports = mongoose.model("Venue", VenueSchema);
