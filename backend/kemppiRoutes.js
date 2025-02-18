const express = require("express");
const weldController = require("./controllers/weldController");
const parametersController = require("./controllers/parametersController");
const machineController = require("./controllers/machineController");
const consumeController = require("./controllers/consumeController");

const router = express.Router();

// get all of the data from the server
router.get("/", weldController.getWelds);

// Gives all of the different models
router.get("/products", machineController.getAllDifferentModels);
// get one of the welding machine data by the serial
router.get("/products/:serial", machineController.getMachineBySerial);

// Get the latest used welding machines from all of the models
router.get("/machines", weldController.getWeldsByTime);
// Get latest used welding machines with same serial
router.get("/machines/:serial", weldController.getWeldsByMachineTime);

// Gives avg for voltage used on certain model
router.get(
  "/statistics/voltage/model/avg/:serial",
  parametersController.getAvgVoltageOfModel
);
// Gives avg for current used on certain model
router.get(
  "/statistics/current/model/avg/:serial",
  parametersController.getAvgCurrentOfModel
);

// Gives avg from all of the avgs on the voltage usage of the devices
router.get(
  "/statistics/voltage/all/avg",
  parametersController.getVoltageAvgAll
);
// Gives avg from all of the avgs on the current used of the devices
router.get(
  "/statistics/current/all/avg",
  parametersController.getCurrentAvgAll
);
// Gives the total consumption by model
router.get(
  "/statistics/material/model/avg/:serial",
  consumeController.getMaterialConsumptionTotal
);
// Gives the total duration by model
router.get(
  "/statistics/duration/model/avg/:serial",
  consumeController.getWeldDurationTotal
);

module.exports = router;
