const { fetchWelds } = require("../mainService");

// shows all the welding machines no filters
const getWelds = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    res.json(welds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldsByLatest = async (req, res) => {
  try {
    const welds = await fetchWelds(req.query);
    // Order welding data from latest based on timestamp
    const sortedWelds = welds.sort(
      (a, b) => new Date(b.timestamp) - new Date(a.timestamp)
    );
    res.json(sortedWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getWeldsByLatestNumber = async (req, res) => {
  try {
    const days = parseInt(req.params.number, 10);
    if (isNaN(days)) {
      return res.status(400).json({ error: "Invalid number parameter" });
    }

    const welds = await fetchWelds({});
    const dateThreshold = new Date();
    dateThreshold.setDate(dateThreshold.getDate() - days);

    // Filter welds from the latest days
    const latestWelds = welds.filter(
      (weld) => new Date(weld.timestamp) >= dateThreshold
    );

    // Sort the filtered welds in descending order by timestamp
    const sortedWelds = latestWelds.sort(
      (a, b) => new Date(b.timestamp) - new Date(a.timestamp)
    );

    res.json(sortedWelds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Returns the latest weld record for each unique welding machine (using serial for separation)
const getWeldsByTime = async (req, res) => {
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

module.exports = {
  getWelds,
  getWeldsByMachineTime,
  getWeldsByTime,
  getWeldsByLatest,
  getWeldsByLatestNumber,
};
