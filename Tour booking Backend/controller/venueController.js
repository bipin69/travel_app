const Venue = require("../model/Venue");

// Create a new venue (Admin only)
exports.createVenue = async (req, res) => {
  try {
    const { name, location, capacity, price, description } = req.body;

    if (!name || !location || !capacity || !price || !description) {
      return res.status(400).json({ error: "All fields are required" });
    }

    console.log("Request Body:", req.body); // Debugging Line
    console.log("Uploaded Files:", req.files); // Debugging Line

    // ✅ Ensure `images` is always an array
    const images = req.files ? req.files.map(file => `/uploads/${file.filename}`) : [];

    const venue = new Venue({
      name,
      location,
      capacity,
      price,
      description,
      images, // ✅ Assign images safely
    });

    await venue.save();
    res.status(201).json({ message: "Venue created successfully", venue });
  } catch (error) {
    console.error("Error Creating Venue:", error); // Debugging Line
    res.status(500).json({ error: error.message });
  }
};


// Get all venues (Public)
exports.getAllVenues = async (req, res) => {
  try {
    const venues = await Venue.find();
    res.json(venues);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get venue by ID (Public)
exports.getVenueById = async (req, res) => {
  try {
    const venue = await Venue.findById(req.params.id);
    if (!venue) return res.status(404).json({ error: "Venue not found" });

    res.json(venue);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update venue (Admin only)
exports.updateVenue = async (req, res) => {
  try {
    let updatedData = req.body;

    // If new images are uploaded, update images
    if (req.files && req.files.length > 0) {
      updatedData.images = req.files.map(file => `/uploads/${file.filename}`);
    }

    const updatedVenue = await Venue.findByIdAndUpdate(req.params.id, updatedData, { new: true });

    if (!updatedVenue) return res.status(404).json({ error: "Venue not found" });

    res.json({ message: "Venue updated successfully", updatedVenue });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Delete venue (Admin only)
exports.deleteVenue = async (req, res) => {
  try {
    const deletedVenue = await Venue.findByIdAndDelete(req.params.id);
    if (!deletedVenue) return res.status(404).json({ error: "Venue not found" });

    res.json({ message: "Venue deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
