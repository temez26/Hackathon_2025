const { fetchWelds } = require("../mainService");

// helper functions that return data instead of sending a response
const getAvgVoltageOfModelData = async (serial, query = {}) => {
  if (!serial) throw new Error("Serial query parameter is required");
  let welds = await fetchWelds(query);

  if (query.dateThreshold) {
    welds = welds.filter(
      (weld) => new Date(weld.timestamp) >= new Date(query.dateThreshold)
    );
  }
  const filteredWelds = welds.filter(
    (weld) =>
      weld.weldingMachine && String(weld.weldingMachine.serial) === serial
  );
  if (filteredWelds.length === 0) {
    throw new Error("No weld records found for the provided serial");
  }
  const voltageData = filteredWelds
    .map((weld) => weld.weldingParameters?.voltage)
    .filter((v) => v !== undefined);
  if (voltageData.length === 0) {
    throw new Error("No voltage data found for the provided serial");
  }
  const avgVoltage =
    voltageData.reduce((sum, v) => sum + v.avg, 0) / voltageData.length;
  const minVoltage = Math.min(...voltageData.map((v) => v.min));
  const maxVoltage = Math.max(...voltageData.map((v) => v.max));

  return {
    serial,
    model: filteredWelds[0].weldingMachine.model,
    avgVoltage,
    minVoltage,
    maxVoltage,
  };
};

const getAvgCurrentOfModelData = async (serial, query = {}) => {
  if (!serial) throw new Error("Serial query parameter is required");
  let welds = await fetchWelds(query);
  if (query.dateThreshold) {
    welds = welds.filter(
      (weld) => new Date(weld.timestamp) >= new Date(query.dateThreshold)
    );
  }
  const filteredWelds = welds.filter(
    (weld) =>
      weld.weldingMachine && String(weld.weldingMachine.serial) === serial
  );
  if (filteredWelds.length === 0) {
    throw new Error("No weld records found for the provided serial");
  }
  const currentData = filteredWelds
    .map((weld) => weld.weldingParameters?.current)
    .filter((c) => c !== undefined);
  if (currentData.length === 0) {
    throw new Error("No current data found for the provided serial");
  }
  const avgCurrent =
    currentData.reduce((sum, c) => sum + c.avg, 0) / currentData.length;
  const minCurrent = Math.min(...currentData.map((c) => c.min));
  const maxCurrent = Math.max(...currentData.map((c) => c.max));

  return {
    serial,
    model: filteredWelds[0].weldingMachine.model,
    avgCurrent,
    minCurrent,
    maxCurrent,
  };
};

// Existing endpoint handlers can call the above helpers:
const getAvgVoltageOfModel = async (req, res) => {
  try {
    const serial = req.params.serial || req.query.serial;

    let query = { ...req.query };
    if (req.params.number) {
      const days = parseInt(req.params.number, 10);
      const dateThreshold = new Date();
      dateThreshold.setDate(dateThreshold.getDate() - days);
      query.dateThreshold = dateThreshold;
    }
    const data = await getAvgVoltageOfModelData(serial, query);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getAvgCurrentOfModel = async (req, res) => {
  try {
    const serial = req.params.serial || req.query.serial;
    let query = { ...req.query };
    if (req.params.number) {
      const days = parseInt(req.params.number, 10);
      const dateThreshold = new Date();
      dateThreshold.setDate(dateThreshold.getDate() - days);
      query.dateThreshold = dateThreshold;
    }
    const data = await getAvgCurrentOfModelData(serial, query);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getVoltageAvgAll = async (req, res) => {
  try {
    let welds = await fetchWelds(req.query);
    if (req.query.dateThreshold) {
      welds = welds.filter(
        (weld) => new Date(weld.timestamp) >= new Date(req.query.dateThreshold)
      );
    }
    const voltageData = welds
      .map((weld) => weld.weldingParameters?.voltage)
      .filter((v) => v !== undefined);
    if (voltageData.length === 0) {
      return res.status(404).json({ error: "No voltage data found" });
    }
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
    let welds = await fetchWelds(req.query);
    if (req.query.dateThreshold) {
      welds = welds.filter(
        (weld) => new Date(weld.timestamp) >= new Date(req.query.dateThreshold)
      );
    }
    const currentData = welds
      .map((weld) => weld.weldingParameters?.current)
      .filter((c) => c !== undefined);
    if (currentData.length === 0) {
      return res.status(404).json({ error: "No current data found" });
    }
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
  getAvgVoltageOfModelData,
  getAvgCurrentOfModelData,
};
