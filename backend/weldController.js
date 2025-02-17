const axios = require("axios");

const API_KEY = "1dfc5a9a0aeb5a96";
const WELDS_URL = "http://hackathon.dev.api.kemppi.com/welds";

// Helper to fetch welds data with optional query parameters.
const fetchWelds = async (query) => {
  const params = {};
  if (query.start) {
    params.start = query.start;
  }
  if (query.end) {
    params.end = query.end;
  }
  const response = await axios.get(WELDS_URL, {
    headers: { "x-api-key": API_KEY },
    params: Object.keys(params).length ? params : undefined,
  });
  return response.data;
};
// shows all the welding machines no filters
const getWelds = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    res.json(welds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldById = (req, res) => {
  const { id } = req.params;
  console.group(req.params);
  // TODO: Implement actual lookup logic. This is a dummy response.
  res.json({ message: `Details for weld ${id}` });
};

// Returns the latest weld record for each unique welding machine (using serial for separation)
const getWeldsByTimestamp = async (req, res) => {
  try {
    const welds = await fetchWelds({});

    // Group welds by serial and keep the record with the latest timestamp for each
    const latestBySerial = {};
    welds.forEach((weld) => {
      if (weld.weldingMachine && weld.weldingMachine.serial) {
        const serial = weld.weldingMachine.serial;
        // If there's no record for this serial or this weld is more recent, update it.
        if (
          !latestBySerial[serial] ||
          new Date(weld.timestamp) > new Date(latestBySerial[serial].timestamp)
        ) {
          latestBySerial[serial] = weld;
        }
      }
    });

    // Convert the object values to an array and sort descending by timestamp
    const result = Object.values(latestBySerial).sort(
      (a, b) => new Date(b.timestamp) - new Date(a.timestamp)
    );

    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
// returns the most latest used welding machines by serial
const getWeldsByMachineTime = async (req, res) => {
  try {
    const { serial } = req.params;
    const welds = await fetchWelds(req.query);
    // Filter welds where weldingMachine.serial matches the provided serial.
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );

    // Sort the filtered welds by timestamp in descending order.
    const sortedWelds = filteredWelds.sort(
      (a, b) => new Date(b.timestamp) - new Date(a.timestamp)
    );

    res.json(sortedWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldStatistics = (req, res) => {
  // TODO: Implement actual statistics aggregation logic
  res.json({ message: "Aggregate welding statistics" });
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

// get all different models with full weld data
const getAllDifferentModels = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    const uniqueWelds = {};

    // Loop through each weld record.
    welds.forEach((weld) => {
      if (weld.weldingMachine && weld.weldingMachine.serial) {
        const serial = weld.weldingMachine.serial;
        // Only add if the serial doesn't exist yet, and store the full record.
        if (!uniqueWelds[serial]) {
          uniqueWelds[serial] = weld;
        }
      }
    });

    // Convert the keyed object into an array.
    const result = Object.values(uniqueWelds);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
// Gets all of the data by one of the welding machine by serial
const getMachineBySerial = async (req, res) => {
  try {
    const { serial } = req.params;
    const welds = await fetchWelds(req.query);

    // Find the first weld record with the matching serial.
    const weldRecord = welds.find(
      (weld) => weld.weldingMachine && weld.weldingMachine.serial === serial
    );

    if (weldRecord) {
      res.json(weldRecord);
    } else {
      res.status(404).json({ error: "Weld record not found" });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
const getVoltage = async (req, res) => {};
const getCurrent = async (req, res) => {};

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
// Gives the total material consumption by model (filtered by serial)
const getMaterialConsumptionTotal = async (req, res) => {
  try {
    const { serial } = req.params;
    if (!serial) {
      return res.status(400).json({ error: "Serial parameter is required" });
    }
    const welds = await fetchWelds(req.query);
    // Filter welds where the weldingMachine serial matches the provided serial.
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );
    if (filteredWelds.length === 0) {
      return res
        .status(404)
        .json({ error: "No weld records found for the provided serial" });
    }
    // Extract material consumption data
    const consumptionData = filteredWelds
      .map((weld) => weld.materialConsumption)
      .filter((cons) => cons !== undefined);
    if (consumptionData.length === 0) {
      return res.status(404).json({
        error: "No material consumption data found for the provided serial",
      });
    }
    // Aggregate (sum) each consumption metric
    const totalConsumption = consumptionData.reduce(
      (acc, cur) => {
        acc.energyConsumptionAsWh += cur.energyConsumptionAsWh;
        acc.wireConsumptionInMeters += cur.wireConsumptionInMeters;
        acc.fillerConsumptionInGrams += cur.fillerConsumptionInGrams;
        acc.gasConsumptionInLiters += cur.gasConsumptionInLiters;
        return acc;
      },
      {
        energyConsumptionAsWh: 0,
        wireConsumptionInMeters: 0,
        fillerConsumptionInGrams: 0,
        gasConsumptionInLiters: 0,
      }
    );

    res.json({
      serial,
      model: filteredWelds[0].weldingMachine.model,
      totalMaterialConsumption: totalConsumption,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
// Calculates the total weld durations by model (filtered by serial)
const getWeldDurationTotal = async (req, res) => {
  try {
    const { serial } = req.params;
    if (!serial) {
      return res.status(400).json({ error: "Serial parameter is required" });
    }
    const welds = await fetchWelds(req.query);
    // Filter welds where the weldingMachine serial matches the provided serial.
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );
    if (filteredWelds.length === 0) {
      return res
        .status(404)
        .json({ error: "No weld records found for the provided serial" });
    }
    // Extract weld duration data
    const durationData = filteredWelds
      .map((weld) => weld.weldDurationMs)
      .filter((duration) => duration !== undefined);
    if (durationData.length === 0) {
      return res.status(404).json({
        error: "No weld duration data found for the provided serial",
      });
    }
    // Aggregate (sum) each duration metric
    const totalDuration = durationData.reduce(
      (acc, cur) => {
        acc.preWeldMs += cur.preWeldMs;
        acc.weldMs += cur.weldMs;
        acc.postWeldMs += cur.postWeldMs;
        acc.totalMs += cur.totalMs;
        return acc;
      },
      {
        preWeldMs: 0,
        weldMs: 0,
        postWeldMs: 0,
        totalMs: 0,
      }
    );

    res.json({
      serial,
      model: filteredWelds[0].weldingMachine.model,
      totalWeldDuration: totalDuration,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
module.exports = {
  getWelds,
  getWeldById,
  getWeldsByMachineTime,
  getWeldsByTimestamp,
  getAvgVoltageOfModel,
  getAvgCurrentOfModel,
  getWeldStatistics,
  getVoltage,
  getCurrent,
  getVoltageAvgAll,
  getCurrentAvgAll,
  getAllDifferentModels,
  getMachineBySerial,
  getMaterialConsumptionTotal,
  getWeldDurationTotal,
};
