const express = require("express");
const cors = require("cors");
const app = express();
const weldController = require("./weldController");

const PORT = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors());

// get all of the data from the server
app.get("/welds", weldController.getWelds);

// Gives all of the different models
app.get("/welds/products", weldController.getAllDifferentModels);
// get one of the welding machine data by the serial
app.get("/welds/products/:serial", weldController.getMachineBySerial);

// Get the 10 latest used welding machines
app.get("/welds/machines", weldController.getWeldsByTimestamp);
// Get 10 latest used welding machine by serial
app.get("/welds/machines/:serial", weldController.getWeldsByMachineTime);

// Gives avg for voltage used on certain model
app.get(
  "/welds/statistics/voltage/model/avg/:serial",
  weldController.getAvgVoltageOfModel
);
// Gives avg for current used on certain model
app.get(
  "/welds/statistics/current/model/avg/:serial",
  weldController.getAvgCurrentOfModel
);

// Gives avg from all of the avgs on the voltage usage of the devices
app.get("/welds/statistics/voltage/all/avg", weldController.getVoltageAvgAll);
// Gives avg from all of the avgs on the current used of the devices
app.get("/welds/statistics/current/all/avg", weldController.getCurrentAvgAll);
// Gives the total consumption by model
app.get(
  "/welds/statistics/material/model/avg/:serial",
  weldController.getMaterialConsumptionTotal
);
// Gives the total duration by model
app.get(
  "/welds/statistics/duration/model/avg/:serial",
  weldController.getWeldDurationTotal
);

app.get("/welds/statistics/voltage/all");
app.get("/welds/statistics/current/all");
// not implemented yet
app.get("/welds/statistics", weldController.getWeldStatistics);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
