require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();

const PORT = process.env.PORT;

// Enable CORS for all routes
app.use(cors());

// Import and mount the routes for "/kemppi" endpoints
const weldsRouter = require("./kemppiRoutes");
app.use("/kemppi", weldsRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
