import 'package:flutter/material.dart';

class RecentUsedMachines extends StatefulWidget {
  @override
  _RecentUsedMachines createState() => _RecentUsedMachines();
}

class _RecentUsedMachines extends State<RecentUsedMachines> {
  final PageController _controller = PageController(viewportFraction: 0.5);
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 5) {
      _currentPage++;
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 1100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Button
          GestureDetector(
            onTap: _previousPage,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                "<",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFf57300),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 30), // Add space between left button and carousel

          // Carousel
          SizedBox(
            width: 900, // Ajusta el ancho del carrusel
            child: PageView.builder(
              controller: _controller,
              itemCount: 6,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 400,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Color(0xFFf57300),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Model",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
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
          SizedBox(width: 30), // Add space between carousel and right button

          // Right Button
          GestureDetector(
            onTap: _nextPage,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                ">",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFf57300),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
