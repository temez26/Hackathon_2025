const { fetchWelds } = require("../mainService");

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
  getMaterialConsumptionTotal,
  getWeldDurationTotal,
};
