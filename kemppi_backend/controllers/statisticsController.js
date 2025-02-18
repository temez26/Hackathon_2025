const parametersController = require("./parametersController");
const consumeController = require("./consumeController");

exports.getAllStatistics = async (req, res) => {
  const { serial, number } = req.params;
  // Check if a number of days was provided; if so, add it as a filter
  const days = number ? parseInt(number, 10) : null;

  // Optionally, create a query filter based on days if needed in the underlying functions
  const query = { ...req.query };
  if (days) {
    // For instance, specify a date threshold: from (current date - days) to today.
    const dateThreshold = new Date();
    dateThreshold.setDate(dateThreshold.getDate() - days);
    query.dateThreshold = dateThreshold;
  }

  try {
    const [voltageStats, currentStats, materialConsumption, weldDuration] =
      await Promise.all([
        parametersController.getAvgVoltageOfModelData(serial, query),
        parametersController.getAvgCurrentOfModelData(serial, query),
        consumeController.getMaterialConsumptionTotalData(serial, query),
        consumeController.getWeldDurationTotalData(serial, query),
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
