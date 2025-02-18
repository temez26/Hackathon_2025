## Endpoints

### Weld Data

- **GET `/welds/`** - Retrieves all weld data from the server.
- **GET `/welds/machines`** - Retrieves the 10 latest used welding machines.
- **GET `/welds/machines/:serial`** - Retrieves the 10 latest welds for a specific machine based on its serial number.

### Machine Information

- **GET `/welds/products`** - Retrieves all available machine models.
- **GET `/welds/products/:serial`** - Retrieves information about a specific machine based on its serial number.

### Welding Statistics

- **GET `/welds/statistics/voltage/model/avg/:serial`** - Retrieves the average voltage usage for a specific model.
- **GET `/welds/statistics/current/model/avg/:serial`** - Retrieves the average current usage for a specific model.
- **GET `/welds/statistics/voltage/all/avg`** - Retrieves the average voltage usage across all devices.
- **GET `/welds/statistics/current/all/avg`** - Retrieves the average current usage across all devices.

### Consumption & Duration

- **GET `/welds/statistics/material/model/avg/:serial`** - Retrieves the total material consumption for a specific model.
- **GET `/welds/statistics/duration/model/avg/:serial`** - Retrieves the total welding duration for a specific model.

## Configuration

- The server runs on port `3000` by default, but you can change this by setting the `PORT` environment variable.
- CORS is enabled for all routes.

## License

This project is licensed under the MIT License.
