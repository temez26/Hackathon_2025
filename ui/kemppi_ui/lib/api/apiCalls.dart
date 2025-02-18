import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kemppi_ui/model/Machine.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:3000';

  Future<dynamic> fetchRecentWelds() async {
    const url = '$baseUrl/kemppi/machines';
    try {
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      //print(response);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Machine> machines =
            jsonData.map((json) => Machine.fromJson(json)).toList();
        //print('Fetched Machines:');
        machines.forEach((machine) {
          //print(machine);
          //print('\n--\n');
        });
        return machines;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> fetchByMachineSerial() async {
    final url = '$baseUrl/kemppi/machines/'; //CHANGE TO welds/machine
    try {
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      //print(response);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Machine> machines =
            jsonData.map((json) => Machine.fromJson(json)).toList();
        //print('Fetched Machines:');
        machines.forEach((machine) {
          print(machine);
          //print('\n--\n');
        });
        return machines;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Add more methods for different API requests as needed
}
