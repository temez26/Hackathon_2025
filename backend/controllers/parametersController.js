const { fetchWelds } = require("../mainService");

// Gets the avg voltage usage per model
const getAvgVoltageOfModel = async (req, res) => {
  console.log("Received serial:", req.params.serial || req.query.serial);
  try {
    const serial = req.params.serial || req.query.serial;
    if (!serial) {
      return res
        .status(400)
        .json({ error: "Serial query parameter is required" });
    }
    const welds = await fetchWelds(req.query);
    // Filter welds for the given serial
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );
    if (filteredWelds.length === 0) {
      return res
        .status(404)
        .json({ error: "No weld records found for the provided serial" });
    }
    // Extract voltage data
    const voltageData = filteredWelds
      .map((weld) => weld.weldingParameters?.voltage)
      .filter((v) => v !== undefined);
    if (voltageData.length === 0) {
      return res
        .status(404)
        .json({ error: "No voltage data found for the provided serial" });
    }
    // Aggregate voltage values
    const avgVoltage =
      voltageData.reduce((sum, v) => sum + v.avg, 0) / voltageData.length;
    const minVoltage = Math.min(...voltageData.map((v) => v.min));
    const maxVoltage = Math.max(...voltageData.map((v) => v.max));

    res.json({
      serial,
      model: filteredWelds[0].weldingMachine.model,
      avgVoltage,
      minVoltage,
      maxVoltage,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Gives avg for current used on a certain model (filtered by serial)
const getAvgCurrentOfModel = async (req, res) => {
  try {
    const serial = req.params.serial || req.query.serial;
    if (!serial) {
      return res
        .status(400)
        .json({ error: "Serial query parameter is required" });
    }
    const welds = await fetchWelds(req.query);
    // Filter welds for the given serial
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );
    if (filteredWelds.length === 0) {
      return res
        .status(404)
        .json({ error: "No weld records found for the provided serial" });
    }
    // Extract current data
    const currentData = filteredWelds
      .map((weld) => weld.weldingParameters?.current)
      .filter((c) => c !== undefined);
    if (currentData.length === 0) {
      return res
        .status(404)
        .json({ error: "No current data found for the provided serial" });
    }
    // Aggregate current values
    const avgCurrent =
      currentData.reduce((sum, c) => sum + c.avg, 0) / currentData.length;
    const minCurrent = Math.min(...currentData.map((c) => c.min));
    const maxCurrent = Math.max(...currentData.map((c) => c.max));

    res.json({
      serial,
      model: filteredWelds[0].weldingMachine.model,
      avgCurrent,
      minCurrent,
      maxCurrent,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
const getVoltageAvgAll = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    // Extract voltage data from each weld.
    const voltageData = welds
      .map((weld) => weld.weldingParameters?.voltage)
      .filter((voltage) => voltage !== undefined);
    if (voltageData.length === 0) {
      return res.status(404).json({ error: "No voltage data found" });
    }
    // Aggregate min, avg, and max values.
    const aggregate = {
      min: Math.min(...voltageData.map((v) => v.min)),
      avg: voltageData.reduce((sum, v) => sum + v.avg, 0) / voltageData.length,
      max: Math.max(...voltageData.map((v) => v.max)),
    };
    res.json(aggregate);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getCurrentAvgAll = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    // Extract current data from each weld.
    const currentData = welds
      .map((weld) => weld.weldingParameters?.current)
      .filter((current) => current !== undefined);
    if (currentData.length === 0) {
      return res.status(404).json({ error: "No current data found" });
    }
    // Aggregate min, avg, and max values.
    const aggregate = {
      min: Math.min(...currentData.map((c) => c.min)),
      avg: currentData.reduce((sum, c) => sum + c.avg, 0) / currentData.length,
      max: Math.max(...currentData.map((c) => c.max)),
    };
    res.json(aggregate);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
module.exports = {
  getAvgVoltageOfModel,
  getAvgCurrentOfModel,
  getVoltageAvgAll,
  getCurrentAvgAll,
};
