const axios = require("axios");

const API_KEY = "1dfc5a9a0aeb5a96";
const WELDS_URL = "http://hackathon.dev.api.kemppi.com/welds";

// Helper to fetch welds data with optional query parameters.
const fetchWelds = async (query = {}) => {
  const params = {};
  if (query.start) params.start = query.start;
  if (query.end) params.end = query.end;

  const response = await axios.get(WELDS_URL, {
    headers: { "x-api-key": API_KEY },
    params: Object.keys(params).length ? params : undefined,
  });
  return response.data;
};

module.exports = { fetchWelds };
