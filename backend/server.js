const express = require("express");
const app = express();
const weldController = require("./weldController");

const PORT = process.env.PORT || 3000;
// get all of the data from the server WORKS
app.get("/welds", weldController.getWelds);

// Get the 10 latest used welding machines WORKS
app.get("/welds/time", weldController.getWeldsByTimestamp);
// Get 10 latest used welding machine by anykind
app.get("/welds/machines/:serial", weldController.getWeldsByMachineSerial);
// Get latest 10 used welding machines by serial
app.get(
  "/welds/machines/machine/:serial",
  weldController.getWeldsByModelLatest
);
// not implemented yet
app.get("/welds/statistics", weldController.getWeldStatistics);
// Gives avg from all of the avgs on the voltage usage of the devices
app.get("/welds/statistics/voltage/all/avg", weldController.getVoltageAvgAll);
// Gives avg from all of the avgs on the current used of the devices
app.get("/welds/statistics/current/all/avg", weldController.getCurrentAvgAll);

app.get("/welds/statistics/voltage/all");
app.get("/welds/statistics/current/all");

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
