import 'package:flutter/material.dart';
import 'package:kemppi_ui/Pluggins/machine_list_carousel.dart';
import 'package:kemppi_ui/api/apiCalls.dart';
import 'package:kemppi_ui/model/Machine.dart';

class MachinesListScreen extends StatefulWidget {
  const MachinesListScreen({super.key});

  @override
  _MachinesListScreenState createState() => _MachinesListScreenState();
}

class _MachinesListScreenState extends State<MachinesListScreen> {
  final ApiClient apiClient =
      ApiClient(); // Create an instance of the ApiClient class
  List<Machine> _machines = [];
  String _data = 'Fetching data...';

  @override
  void initState() {
    super.initState();
    fetchRecentWelds();
  }

  Future<void> fetchRecentWelds() async {
    try {
      final machines = await apiClient.fetchByMachineSerial();
      setState(() {
        _machines = machines;
        _data = machines.toString();
        print(_data);
      });
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _Header(),
      body: SingleChildScrollView(
        child: Column(children: [_Body(machines: _machines) /* _Footer()*/]),
      ),
    );
  }
}

class _Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Image.asset('lib/Assets/Images/kemppi_logo.png', height: 110),
      centerTitle: false,
      toolbarHeight: 450,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _Body extends StatelessWidget {
  final List<Machine> machines;

  _Body({required this.machines});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      // Wrap with Center widget
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'Welding Machines',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Proxima Nova',
                color: Color(0xFFf57300),
              ),
            ),
            SizedBox(height: 20),
            MachineListCarousel(list_machines: machines),
            // Add more widgets here if needed
          ],
        ),
      ),
    ));
  }
}
