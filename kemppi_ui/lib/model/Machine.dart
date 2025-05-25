import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Machine {
  final String timestamp;
  final WeldingMachine weldingMachine;
  final WeldingParameters weldingParameters;
  final WeldDurationMs weldDurationMs;
  final MaterialConsumption materialConsumption;

  Machine({
    required this.timestamp,
    required this.weldingMachine,
    required this.weldingParameters,
    required this.weldDurationMs,
    required this.materialConsumption,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      timestamp: json['timestamp'],
      weldingMachine: WeldingMachine.fromJson(json['weldingMachine']),
      weldingParameters: WeldingParameters.fromJson(json['weldingParameters']),
      weldDurationMs: WeldDurationMs.fromJson(json['weldDurationMs']),
      materialConsumption:
          MaterialConsumption.fromJson(json['materialConsumption']),
    );
  }

  @override
  String toString() {
    return 'Machine(timestamp: $timestamp, weldingMachine: $weldingMachine, weldingParameters: $weldingParameters, weldDurationMs: $weldDurationMs, materialConsumption: $materialConsumption)';
  }
}

class WeldingMachine {
  final String model;
  final String serial;
  final String name;
  final String group;

  WeldingMachine({
    required this.model,
    required this.serial,
    required this.name,
    required this.group,
  });

  factory WeldingMachine.fromJson(Map<String, dynamic> json) {
    return WeldingMachine(
      model: json['model'],
      serial: json['serial'],
      name: json['name'],
      group: json['group'],
    );
  }

  @override
  String toString() {
    return 'WeldingMachine(model: $model, serial: $serial, name: $name, group: $group)';
  }
}

class WeldingParameters {
  final Parameter current;
  final Parameter voltage;

  WeldingParameters({
    required this.current,
    required this.voltage,
  });

  factory WeldingParameters.fromJson(Map<String, dynamic> json) {
    return WeldingParameters(
      current: Parameter.fromJson(json['current']),
      voltage: Parameter.fromJson(json['voltage']),
    );
  }

  @override
  String toString() {
    return 'WeldingParameters(current: $current, voltage: $voltage)';
  }
}

class Parameter {
  final int min;
  final int avg;
  final int max;

  Parameter({
    required this.min,
    required this.avg,
    required this.max,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      min: json['min'],
      avg: json['avg'],
      max: json['max'],
    );
  }

  @override
  String toString() {
    return 'Parameter(min: $min, avg: $avg, max: $max)';
  }
}

class WeldDurationMs {
  final int preWeldMs;
  final int weldMs;
  final int postWeldMs;
  final int totalMs;

  WeldDurationMs({
    required this.preWeldMs,
    required this.weldMs,
    required this.postWeldMs,
    required this.totalMs,
  });

  factory WeldDurationMs.fromJson(Map<String, dynamic> json) {
    return WeldDurationMs(
      preWeldMs: json['preWeldMs'],
      weldMs: json['weldMs'],
      postWeldMs: json['postWeldMs'],
      totalMs: json['totalMs'],
    );
  }

  @override
  String toString() {
    return 'WeldDurationMs(preWeldMs: $preWeldMs, weldMs: $weldMs, postWeldMs: $postWeldMs, totalMs: $totalMs)';
  }
}

class MaterialConsumption {
  final double energyConsumptionAsWh;
  final double wireConsumptionInMeters;
  final double fillerConsumptionInGrams;
  final double gasConsumptionInLiters;

  MaterialConsumption({
    required this.energyConsumptionAsWh,
    required this.wireConsumptionInMeters,
    required this.fillerConsumptionInGrams,
    required this.gasConsumptionInLiters,
  });

  factory MaterialConsumption.fromJson(Map<String, dynamic> json) {
    return MaterialConsumption(
      energyConsumptionAsWh: json['energyConsumptionAsWh'],
      wireConsumptionInMeters: json['wireConsumptionInMeters'],
      fillerConsumptionInGrams: json['fillerConsumptionInGrams'],
      gasConsumptionInLiters: json['gasConsumptionInLiters'],
    );
  }

  @override
  String toString() {
    return 'MaterialConsumption(energyConsumptionAsWh: $energyConsumptionAsWh, wireConsumptionInMeters: $wireConsumptionInMeters, fillerConsumptionInGrams: $fillerConsumptionInGrams, gasConsumptionInLiters: $gasConsumptionInLiters)';
  }
}
