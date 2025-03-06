// app.js
require("dotenv").config();
const express = require("express");
const mongoose = require("./config/db");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const rateLimit = require("express-rate-limit");
const path = require("path");
const connectDb = require("./config/db");


// Import routes
const userRoutes = require("./routes/userRoutes");
const venueRoutes = require("./routes/venueRoute");
const bookingRoutes = require("./routes/BookingRoute");
const contactRoutes = require("./routes/contactRoute"); // Import the contact route
const storyRoutes = require("./routes/StoryRoute");
const dashboardRoutes = require("./routes/dashboardRoutes.JS");





const app = express();

// ✅ Connect to the database
connectDb();

// ✅ Fix: Allow CORS only for frontend & credentials
app.use(cors({
  origin: "http://localhost:5173",
  credentials: true,
  methods: ["GET", "POST", "PUT", "DELETE"]
}));

// ✅ Middleware (Reordered)
app.use(express.json());
app.use(helmet());
app.use(morgan("dev"));

// ✅ Fix: CORS issue with Static File Serving
app.use("/uploads", express.static(path.join(__dirname, "uploads"), {
  setHeaders: (res, path) => {
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Cross-Origin-Resource-Policy", "cross-origin"); // Fix same-origin issue
  }
}));

// ✅ Rate Limiting (Prevent brute-force attacks)
// const limiter = rateLimit({
//   windowMs: 15 * 60 * 1000, // 15 minutes
//   max: 100, // Limit each IP to 100 requests
//   message: "Too many requests from this IP, please try again later.",
// });
// app.use(limiter);

// ✅ Routes
app.use("/api/users", userRoutes);
app.use("/api/venues", venueRoutes);
app.use("/api/bookings", bookingRoutes);
app.use("/api/contact", contactRoutes); // Add contact route
app.use("/api/stories", storyRoutes);
app.use("/api/dashboard", dashboardRoutes);


// ✅ Root Route
app.get("/", (req, res) => {
  res.send("Welcome to the Venue Booking API!");
});

// ✅ Global Error Handling Middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: "Something went wrong!" });
});

module.exports = app; // Export for tests
