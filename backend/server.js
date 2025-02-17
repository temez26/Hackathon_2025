const express = require("express");
const axios = require("axios");
const app = express();

const PORT = process.env.PORT || 3000;

app.get("/welds", async (req, res) => {
  try {
    const apiKey = "1dfc5a9a0aeb5a96";
    const response = await axios.get(
      "http://hackathon.dev.api.kemppi.com/welds",
      {
        headers: {
          Authorization: `ApiKey ${apiKey}`,
        },
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
