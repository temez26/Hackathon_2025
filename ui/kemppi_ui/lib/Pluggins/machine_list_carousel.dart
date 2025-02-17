import 'package:flutter/material.dart';
import 'package:kemppi_ui/model/Machine.dart';
import 'package:kemppi_ui/Pluggins/machineDetail_popup.dart';

class MachineListCarousel extends StatefulWidget {
  final List<Machine> list_machines;
  MachineListCarousel({required this.list_machines});

  @override
  _MachineListCarouselState createState() => _MachineListCarouselState();
}

class _MachineListCarouselState extends State<MachineListCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.6);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 800,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.list_machines.length,
        itemBuilder: (context, index) {
          final machine = widget.list_machines[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 40, right: 40), // Espaciado interno
                decoration: BoxDecoration(
                  //color: Colors.grey[300], // Fondo gris claro
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.0),
                    Text(
                      "${machine.weldingMachine.model}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Proxima Nova'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Name: ${machine.weldingMachine.name}",
                      style: TextStyle(
                          fontSize: 23,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Proxima Nova'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Serial Number: ${machine.weldingMachine.serial}",
                      style: TextStyle(
                          fontSize: 23,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Proxima Nova'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Group: ${machine.weldingMachine.group}",
                      style: TextStyle(
                          fontSize: 23,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Proxima Nova'),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        backgroundColor: Color(0xFFf57300),
                        side: BorderSide(color: Color(0xFFf57300), width: 2),
                      ),
                      onPressed: () {
                        MachinedetailPopup(machine: machine)
                            .showWeldingPopup(context);
                      },
                      child: Text('More',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Proxima Nova')),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
