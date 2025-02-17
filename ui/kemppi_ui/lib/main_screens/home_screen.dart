import 'package:flutter/material.dart';
import 'package:kemppi_ui/Pluggins/carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      toolbarHeight: 400,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
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
            Text(
              "Recent Welding Data",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFf57300),
                fontFamily: 'Proxima Nova',
              ),
            ),
            SizedBox(height: 8), // Adds spacing between title and text
            //CustomCarouselFB2(),
            SizedBox(height: 8),
            Text(
              "Trends",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFf57300),
                fontFamily: 'Proxima Nova',
              ),
            ),
            SizedBox(height: 8),
            Text(
              "text",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF414141),
                fontFamily: 'Proxima Nova',
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Summary",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFf57300),
                fontFamily: 'Proxima Nova',
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Recently used machines",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFf57300),
                fontFamily: 'Proxima Nova',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
