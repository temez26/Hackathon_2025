require("dotenv").config();
const axios = require("axios");

const API_KEY = process.env.API_KEY;
const WELDS_URL = process.env.WELDS_URL;

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
