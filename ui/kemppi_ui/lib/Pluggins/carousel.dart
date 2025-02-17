import 'package:flutter/material.dart';

class SimpleCarousel extends StatefulWidget {
  @override
  _SimpleCarouselState createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.6);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _controller,
        itemCount: ImageInfo.values.length,
        itemBuilder: (context, index) {
          final image = ImageInfo.values[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Gray background
                  border: Border.all(
                      color: Colors.orange, width: 4), // Orange border
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        image.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        image.subtitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum ImageInfo {
  image0('The Flow', 'Sponsored | Season 1 Now Streaming'),
  image1('Through the Pane', 'Sponsored | Season 1 Now Streaming'),
  image2('Iridescence', 'Sponsored | Season 1 Now Streaming'),
  image3('Sea Change', 'Sponsored | Season 1 Now Streaming'),
  image4('Blue Symphony', 'Sponsored | Season 1 Now Streaming'),
  image5('When It Rains', 'Sponsored | Season 1 Now Streaming');

  const ImageInfo(this.title, this.subtitle);
  final String title;
  final String subtitle;
}
