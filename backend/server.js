require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const weldController = require("./controllers/weldController");
const parametersController = require("./controllers/parametersController");
const machineController = require("./controllers/machineController");
const consumeController = require("./controllers/consumeController");

const PORT = process.env.PORT;

// Enable CORS for all routes
app.use(cors());

// Create a router for "/kemppi" endpoints
const weldsRouter = express.Router();

// get all of the data from the server
weldsRouter.get("/", weldController.getWelds);

// Gives all of the different models
weldsRouter.get("/products", machineController.getAllDifferentModels);
// get one of the welding machine data by the serial
weldsRouter.get("/products/:serial", machineController.getMachineBySerial);

// Get the latest used welding machines from all of the models
weldsRouter.get("/machines", weldController.getWeldsByTime);
// Get latest used welding machines with same serial
weldsRouter.get("/machines/:serial", weldController.getWeldsByMachineTime);

// Gives avg for voltage used on certain model
weldsRouter.get(
  "/statistics/voltage/model/avg/:serial",
  parametersController.getAvgVoltageOfModel
);
// Gives avg for current used on certain model
weldsRouter.get(
  "/statistics/current/model/avg/:serial",
  parametersController.getAvgCurrentOfModel
);

// Gives avg from all of the avgs on the voltage usage of the devices
weldsRouter.get(
  "/statistics/voltage/all/avg",
  parametersController.getVoltageAvgAll
);
// Gives avg from all of the avgs on the current used of the devices
weldsRouter.get(
  "/statistics/current/all/avg",
  parametersController.getCurrentAvgAll
);
// Gives the total consumption by model
weldsRouter.get(
  "/statistics/material/model/avg/:serial",
  consumeController.getMaterialConsumptionTotal
);
// Gives the total duration by model
weldsRouter.get(
  "/statistics/duration/model/avg/:serial",
  consumeController.getWeldDurationTotal
);

// Mount the router for "/kemppi" endpoints
app.use("/kemppi", weldsRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
