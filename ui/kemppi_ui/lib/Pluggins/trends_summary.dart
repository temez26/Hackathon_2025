import 'package:flutter/material.dart';
import 'package:kemppi_ui/api/apiCalls.dart';
import 'package:kemppi_ui/model/Machine.dart';
import 'package:kemppi_ui/model/StatisticsModel.dart';

class TrendsSummary extends StatefulWidget {
  final List<Machine> list_machines;
  const TrendsSummary({required this.list_machines});

  @override
  _TrendsSummaryState createState() => _TrendsSummaryState();
}

class _TrendsSummaryState extends State<TrendsSummary> {
  final ApiClient apiClient = ApiClient();
  List<Statistics> _statistics = [];
  String _selectedPeriod = 'All';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataIfNeeded();
  }

  void _fetchDataIfNeeded() {
    for (var machine in widget.list_machines) {
      _fetchStatistics(machine.weldingMachine.serial, _selectedPeriod);
    }
  }

  Future<void> _fetchStatistics(
      String serial_number, String _selectedPeriod) async {
    setState(() {
      _isLoading = true;
    });
    _statistics = [];
    try {
      final data = await apiClient.fetchStatisticsBySerial(
          serial_number, _selectedPeriod);
      setState(() {
        _statistics.add(data['statistics']);
      });
    } catch (e) {
      print('Error fetching statistics: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedPeriod,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Proxima Nova',
                  color: Color(0xFFf57300),
                ),
              ),
              DropdownButton<String>(
                value: _selectedPeriod,
                items: <String>['7 days', '30 days', 'All'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedPeriod = newValue;
                      _fetchDataIfNeeded();
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Serial')),
                  DataColumn(label: Text('Current (A)')),
                  DataColumn(label: Text('Voltage (V)')),
                  DataColumn(label: Text('Preweld (ms)')),
                  DataColumn(label: Text('Weld (ms)')),
                  DataColumn(label: Text('Postweld (ms)')),
                  DataColumn(label: Text('Energy (Wh)')),
                  DataColumn(label: Text('Wire (m)')),
                  DataColumn(label: Text('Filler (g)')),
                  DataColumn(label: Text('Gas (L)')),
                ],
                rows: _statistics.map((stat) {
                  return DataRow(cells: [
                    DataCell(Text(stat.voltageStats.serial)),
                    DataCell(Text(stat.currentStats.avgCurrent.toString())),
                    DataCell(Text(stat.voltageStats.avgVoltage.toString())),
                    DataCell(Text(stat.weldDuration.totalWeldDuration.preWeldMs
                        .toString())),
                    DataCell(Text(
                        stat.weldDuration.totalWeldDuration.weldMs.toString())),
                    DataCell(Text(stat.weldDuration.totalWeldDuration.postWeldMs
                        .toString())),
                    DataCell(Text(stat.materialConsumption
                        .totalMaterialConsumption.energyConsumptionAsWh
                        .toString())),
                    DataCell(Text(stat.materialConsumption
                        .totalMaterialConsumption.wireConsumptionInMeters
                        .toString())),
                    DataCell(Text(stat.materialConsumption
                        .totalMaterialConsumption.fillerConsumptionInGrams
                        .toString())),
                    DataCell(Text(stat.materialConsumption
                        .totalMaterialConsumption.gasConsumptionInLiters
                        .toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
