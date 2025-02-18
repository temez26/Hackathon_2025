import 'package:flutter/material.dart';
import 'package:kemppi_ui/Pluggins/machine_list_carousel.dart';
import 'package:kemppi_ui/Pluggins/recent_data_carousel.dart';
import 'package:kemppi_ui/Pluggins/recent_used_machines.dart';
import 'package:kemppi_ui/Pluggins/tabbar.dart';
import 'package:kemppi_ui/api/apiCalls.dart';
import 'package:kemppi_ui/model/Machine.dart';
import 'package:kemppi_ui/Pluggins/slide_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient apiClient =
      ApiClient(); // Create an instance of the ApiClient class
  List<Machine> _recentmachines = [];
  List<Machine> _allmachines = [];
  String _data = 'Fetching data...';

  @override
  void initState() {
    super.initState();
    fetchRecentWelds();
    fetchAlltMachines();
  }

  Future<void> fetchRecentWelds() async {
    try {
      final machines = await apiClient.fetchRecentWelds();
      setState(() {
        _recentmachines = machines;
        _data = machines.toString();
        print(_data);
      });
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  Future<void> fetchAlltMachines() async {
    try {
      final machines = await apiClient.fetchByMachineSerial();
      setState(() {
        _allmachines = machines;
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
      endDrawer: SlideMenu(),
      body: SingleChildScrollView(
        child: Column(children: [
          _Body(
            recentmachines: _recentmachines,
            allmachines: _allmachines,
          ) /* _Footer()*/
        ]),
      ),
    );
  }
}

class _Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      title: Image.asset('lib/Assets/Images/kemppi_logo.png', height: 110),
      centerTitle: false,
      toolbarHeight: 450,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: IconButton(
            icon: Icon(Icons.menu, size: 40), // Increase icon size
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _Body extends StatelessWidget {
  final List<Machine> recentmachines;
  final List<Machine> allmachines;

  _Body({required this.recentmachines, required this.allmachines});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30), // Adds spacing between title and text
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 50, // Ajusta este valor según el tamaño deseado
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey,
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xFFf57300), width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        tabs: const [
                          TabItem(title: 'Recent Welding Data'),
                          TabItem(title: 'Trends and Summary'),
                          TabItem(title: 'Models and Machines'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 500, // Adjust the height as needed
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set the width to the screen width
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: RecentDataList(list_machines: recentmachines),
                        ),
                        Center(child: Text('Archived Page')),
                        Center(
                            child: MachineListCarousel(
                          list_machines: allmachines,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
