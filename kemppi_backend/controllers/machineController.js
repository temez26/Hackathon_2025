const { fetchWelds } = require("../mainService");
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
module.exports = {
  getAllDifferentModels,
  getMachineBySerial,
};
