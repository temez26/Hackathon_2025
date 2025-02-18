import 'package:flutter/material.dart';
import 'package:kemppi_ui/model/Machine.dart';
import 'package:intl/intl.dart';

class RecentDataList extends StatefulWidget {
  final List<Machine> list_machines;
  RecentDataList({required this.list_machines});

  @override
  _RecentDataList createState() => _RecentDataList();
}

class _RecentDataList extends State<RecentDataList> {
  String _searchText = "";
  List<Machine> _filteredMachines = [];

  @override
  void initState() {
    super.initState();
    _filteredMachines = widget.list_machines;
  }

  void _filterMachines(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredMachines = widget.list_machines;
      } else {
        _filteredMachines = widget.list_machines
            .where((machine) => machine.weldingMachine.model
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString); // Convert String to DateTime
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterMachines,
            decoration: InputDecoration(
              labelText: 'Filter by model',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border

                borderSide: BorderSide(
                    color: Color(0xFFf57300), width: 2), // Orange border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border
                borderSide: BorderSide(
                    color: Color(0xFFf57300), width: 2), // Orange border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border
                borderSide: BorderSide(
                    color: Color(0xFFf57300), width: 2), // Orange border
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 1500, // Full width of the screen
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Background color
                  border: Border.all(
                      color: Color(0xFFf57300), width: 2), // Orange border
                  borderRadius: BorderRadius.circular(6), // Rounded border
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(1),
                    7: FlexColumnWidth(1),
                    8: FlexColumnWidth(1),
                    9: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text('Timestamp',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Model',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Serial Number',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Group',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Current',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Voltage',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Energy Consump',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Wire Consump',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Filler Consump',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                        Text('Gas Consump',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Proxima Nova')),
                      ],
                    ),
                  ],
                ),
              ),
              ..._filteredMachines.map((machine) {
                return Container(
                  width: 1500, // Full width of the screen
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Background color
                    border: Border.all(
                        color: Colors.grey, width: 2), // Orange border
                    borderRadius: BorderRadius.circular(6), // Rounded border
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(_formatDate(machine.timestamp.toString()),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(machine.weldingMachine.model.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(machine.weldingMachine.serial.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(machine.weldingMachine.group.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(machine.weldingParameters.current.avg.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(machine.weldingParameters.voltage.avg.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(
                              machine.materialConsumption.energyConsumptionAsWh
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(
                              machine
                                  .materialConsumption.wireConsumptionInMeters
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(
                              machine
                                  .materialConsumption.fillerConsumptionInGrams
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                          Text(
                              machine.materialConsumption.gasConsumptionInLiters
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Proxima Nova')),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
