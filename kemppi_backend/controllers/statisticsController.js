const parametersController = require("./parametersController");
const consumeController = require("./consumeController");

exports.getAllStatistics = async (req, res) => {
  const { serial } = req.params;
  console.log(req.params);

  try {
    const [voltageStats, currentStats, materialConsumption, weldDuration] =
      await Promise.all([
        parametersController.getAvgVoltageOfModelData(serial, req.query),
        parametersController.getAvgCurrentOfModelData(serial, req.query),
        consumeController.getMaterialConsumptionTotalData(serial, req.query),
        consumeController.getWeldDurationTotalData(serial, req.query),
      ]);

    res.json({
      voltageStats,
      currentStats,
      materialConsumption,
      weldDuration,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
