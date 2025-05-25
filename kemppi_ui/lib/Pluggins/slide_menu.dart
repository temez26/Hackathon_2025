import 'package:flutter/material.dart';
import 'package:kemppi_ui/main_screens/home_screen.dart';
import 'package:kemppi_ui/main_screens/machines_list_screen.dart';

class SlideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      shape: null,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          padding: EdgeInsets.only(top: 40),
          children: <Widget>[
            ListTile(
              //leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Proxima Nova')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            SizedBox(height: 20), // Add space between elements
            ListTile(
              //leading: Icon(Icons.build, color: Colors.white),
              title: Text('Welding Machines',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Proxima Nova')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MachinesListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
