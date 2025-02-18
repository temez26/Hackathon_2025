import 'package:flutter/material.dart';
import 'package:kemppi_ui/model/Machine.dart';

class RecentDataCarousel extends StatefulWidget {
  final List<Machine> list_machines;
  RecentDataCarousel({required this.list_machines});

  @override
  _RecentDataCarousel createState() => _RecentDataCarousel();
}

class _RecentDataCarousel extends State<RecentDataCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.6);
  String _searchText = "";
  List<Machine> _filteredMachines = [];

  @override
  void initState() {
    super.initState();
    _filterMachines("");
    _filteredMachines =
        widget.list_machines; // Ensure all machines are shown initially
    print(_filteredMachines);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border
                borderSide:
                    BorderSide(color: Color(0xFFf57300)), // Orange border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border
                borderSide:
                    BorderSide(color: Color(0xFFf57300)), // Orange border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Rounded border
                borderSide:
                    BorderSide(color: Color(0xFFf57300)), // Orange border
              ),
            ),
          ),
        ),
        SizedBox(
          height: 350,
          width: 800,
          child: PageView.builder(
            controller: _controller,
            itemCount: _filteredMachines.length,
            itemBuilder: (context, index) {
              final machine = _filteredMachines[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40), // Espaciado interno
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Fondo gris claro
                      border: Border.all(color: Color(0xFFf57300), width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Corriente y Voltaje
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Current:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 180),
                            Text(
                              "Voltage:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${machine.weldingParameters.current.avg} (avg)",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                              ),
                            ),
                            SizedBox(width: 180),
                            Text(
                              "${machine.weldingParameters.voltage.avg} (avg)",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "Weld Duration Total: ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${machine.weldDurationMs.totalMs} ms",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        // Material Consumption
                        Text(
                          "Material Consumption:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Proxima Nova'),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "energy: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                    Text(
                                      "${machine.materialConsumption.energyConsumptionAsWh} Wh",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "wire: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                    Text(
                                      "${machine.materialConsumption.wireConsumptionInMeters} m",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "filler: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                    Text(
                                      "${machine.materialConsumption.fillerConsumptionInGrams} g",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "gas: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                    Text(
                                      "${machine.materialConsumption.gasConsumptionInLiters} l",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        // Modelo
                        Center(
                          child: Text(
                            "Model: ${machine.weldingMachine.model}",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Proxima Nova'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
