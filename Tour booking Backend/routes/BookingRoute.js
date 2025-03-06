const express = require("express");
const {
  createBooking,
  getBookingById,
  getUserBookings, //  New function for getting logged-in user's bookings
  getAllBookings, // Only for admins
  cancelBooking,
  approveBooking,
  deleteBooking,
} = require("../controller/BookingController");
const { authMiddleware, adminMiddleware } = require("../middleware/authMiddleware");

const router = express.Router();

router.post("/", authMiddleware, createBooking); // User books a venue
router.get("/my-bookings", authMiddleware, getUserBookings); // ✅ Get bookings for logged-in user
router.get("/:id", authMiddleware, getBookingById); // Get single booking
router.get("/", authMiddleware, adminMiddleware, getAllBookings); // Admin gets all bookings
router.put("/:id/cancel", authMiddleware, cancelBooking); // User cancels booking
router.put("/:id/approve", authMiddleware, adminMiddleware, approveBooking); // Admin approves booking
router.delete("/:id", authMiddleware, adminMiddleware, deleteBooking); // Admin deletes a booking

module.exports = router;
