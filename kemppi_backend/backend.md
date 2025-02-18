## Endpoints

### Weld Data

- **GET `/kemppi/`** - Retrieves all weld data from the server.
- **GET `/kemppi/machines`** - Retrieves the 10 latest used welding machines.
- **GET `/kemppi/machines/:serial`** - Retrieves the 10 latest welds for a specific machine based on its serial number.

### Machine Information

- **GET `/kemppi/products`** - Retrieves all available machine models.
- **GET `/kemppi/products/:serial`** - Retrieves information about a specific machine based on its serial number.

### Welding Statistics

- **GET `/kemppi/statistics/voltage/model/avg/:serial`** - Retrieves the average voltage usage for a specific model.
- **GET `/kemppi/statistics/current/model/avg/:serial`** - Retrieves the average current usage for a specific model.
- **GET `/kemppi/statistics/voltage/all/avg`** - Retrieves the average voltage usage across all devices.
- **GET `/kemppi/statistics/current/all/avg`** - Retrieves the average current usage across all devices.

### Consumption & Duration

- **GET `/kemppi/statistics/material/model/avg/:serial`** - Retrieves the total material consumption for a specific model.
- **GET `/kemppi/statistics/duration/model/avg/:serial`** - Retrieves the total welding duration for a specific model.

### Get all of the statistic data

- **GET `/kemppi/statistics/:serial`** - Retrieves the all of the statisticdata

## Configuration

- The server runs on port `3000` by default, but you can change this by setting the `PORT` environment variable.
- CORS is enabled for all routes.
