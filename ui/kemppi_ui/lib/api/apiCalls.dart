import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeldDataWidget extends StatefulWidget {
  const WeldDataWidget({Key? key}) : super(key: key);

  @override
  State<WeldDataWidget> createState() => _WeldDataWidgetState();
}

class _WeldDataWidgetState extends State<WeldDataWidget> {
  @override
  void initState() {
    super.initState();
    fetchWelds();
  }

  Future<void> fetchWelds() async {
    // Note: if using an Android emulator, use '10.0.2.2' instead of 'localhost'
    const url = 'http://localhost:3000/welds';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data); // Print the fetched data to the console
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Check your console for output.');
  }
}
