const app = require("./app");

// Use dynamic port selection for testing
const PORT = process.env.PORT || 3000;

const server = app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});

// ✅ Export the server instance properly
module.exports = server; 
