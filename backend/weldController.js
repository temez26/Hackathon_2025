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

const getWeldsByMachineSerial = async (req, res) => {
  try {
    const { serial } = req.params;
    const welds = await fetchWelds(req.query);
    // Filter welds where weldingMachine.serial matches the provided serial.
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === serial
    );
    res.json(filteredWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldsByTimestamp = async (req, res) => {
  try {
    const { timestampStart, timestampEnd } = req.query;
    let welds = await fetchWelds({});
    if (timestampStart || timestampEnd) {
      const startTime = timestampStart ? new Date(timestampStart) : new Date(0);
      const endTime = timestampEnd ? new Date(timestampEnd) : new Date();
      welds = welds.filter((weld) => {
        const weldTime = new Date(weld.timestamp);
        return weldTime >= startTime && weldTime <= endTime;
      });
    }
    // Sort welds by timestamp in descending order and get the 10 most recent
    welds.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
    const recentWelds = welds.slice(0, 10);
    res.json(recentWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
// filters the models with serial and shows the 10 most recently used
const getWeldsByModelLatest = async (req, res) => {
  try {
    const { model } = req.params;
    const welds = await fetchWelds(req.query);
    // Filter welds where weldingMachine.model matches the provided model.
    const filteredWelds = welds.filter(
      (weld) =>
        weld.weldingMachine && String(weld.weldingMachine.serial) === model
    );
    // Sort welds by timestamp in descending order and get the 10 most recent
    filteredWelds.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
    const recentWelds = filteredWelds.slice(0, 10);
    res.json(recentWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldStatistics = (req, res) => {
  // TODO: Implement actual statistics aggregation logic
  res.json({ message: "Aggregate welding statistics" });
};

const getVoltage = async (req, res) => {
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

const getCurrent = async (req, res) => {
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
  getWelds,
  getWeldById,
  getWeldsByMachineSerial,
  getWeldsByTimestamp,
  getWeldsByModelLatest,
  getWeldStatistics,
  getVoltage,
  getCurrent,
};
