const express = require("express");
const app = express();
const weldController = require("./weldController");

const PORT = process.env.PORT || 3000;

app.get("/welds", weldController.getWelds);

//app.get("/welds/:id", weldController.getWeldById);
app.get("/welds/time", weldController.getWeldsByTimestamp);
//app.get("/welds/machine/:serial", weldController.getWeldsByMachineSerial);
app.get("/welds/machine/:model", weldController.getWeldsByModelLatest);
app.get("/welds/statistics", weldController.getWeldStatistics);
app.get("/welds/statistics/voltage", weldController.getVoltage);
app.get("/welds/statistics/current", weldController.getCurrent);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
