const { fetchWelds } = require("../mainService");

// New helper function that returns total material consumption data
const getMaterialConsumptionTotalData = async (serial, query = {}) => {
  if (!serial) {
    throw new Error("Serial parameter is required");
  }
  const welds = await fetchWelds(query);
  const filteredWelds = welds.filter(
    (weld) =>
      weld.weldingMachine && String(weld.weldingMachine.serial) === serial
  );
  if (filteredWelds.length === 0) {
    throw new Error("No weld records found for the provided serial");
  }
  const consumptionData = filteredWelds
    .map((weld) => weld.materialConsumption)
    .filter((cons) => cons !== undefined);
  if (consumptionData.length === 0) {
    throw new Error(
      "No material consumption data found for the provided serial"
    );
  }
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

  return {
    serial,
    model: filteredWelds[0].weldingMachine.model,
    totalMaterialConsumption: totalConsumption,
  };
};

// New helper function that returns total weld duration data
const getWeldDurationTotalData = async (serial, query = {}) => {
  if (!serial) {
    throw new Error("Serial parameter is required");
  }
  const welds = await fetchWelds(query);
  const filteredWelds = welds.filter(
    (weld) =>
      weld.weldingMachine && String(weld.weldingMachine.serial) === serial
  );
  if (filteredWelds.length === 0) {
    throw new Error("No weld records found for the provided serial");
  }
  const durationData = filteredWelds
    .map((weld) => weld.weldDurationMs)
    .filter((duration) => duration !== undefined);
  if (durationData.length === 0) {
    throw new Error("No weld duration data found for the provided serial");
  }
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

  return {
    serial,
    model: filteredWelds[0].weldingMachine.model,
    totalWeldDuration: totalDuration,
  };
};

// Existing endpoint handlers can now call the helper functions if needed
const getMaterialConsumptionTotal = async (req, res) => {
  try {
    const { serial } = req.params;
    const data = await getMaterialConsumptionTotalData(serial, req.query);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldDurationTotal = async (req, res) => {
  try {
    const { serial } = req.params;
    const data = await getWeldDurationTotalData(serial, req.query);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getMaterialConsumptionTotal,
  getWeldDurationTotal,
  getMaterialConsumptionTotalData,
  getWeldDurationTotalData,
};
