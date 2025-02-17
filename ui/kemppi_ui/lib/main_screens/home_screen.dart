import 'package:flutter/material.dart';
import 'package:kemppi_ui/Pluggins/recent_data_carousel.dart';
import 'package:kemppi_ui/Pluggins/recent_used_machines.dart';
import 'package:kemppi_ui/Pluggins/tabbar.dart';
import 'package:kemppi_ui/api/apiCalls.dart';
import 'package:kemppi_ui/Pluggins/recent_data_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient apiClient =
      ApiClient(); // Create an instance of the ApiClient class
  String _data = 'Fetching data...';

  @override
  void initState() {
    super.initState();
    fetchRecentWelds();
  }

  Future<void> fetchRecentWelds() async {
    try {
      final data = await apiClient.fetchRecentWelds();
      setState(() {
        _data = data.toString();
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
        child: Column(children: [_Body() /* _Footer()*/]),
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 8), // Adds spacing between title and text
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
                          border: Border.all(
                            color: Color(0xFFf57300),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        tabs: const [
                          TabItem(title: 'Recent Welding Data'),
                          TabItem(title: 'Trends and Summary'),
                          TabItem(title: 'Recently used Machines'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 400, // Adjust the height as needed
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set the width to the screen width,
                    child: TabBarView(
                      children: [
                        Center(child: RecentDataCarousel()),
                        Center(child: Text('Archived Page')),
                        Center(child: RecentUsedMachines()),
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
