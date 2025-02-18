import 'package:flutter/material.dart';

class Statistics {
  final VoltageStats voltageStats;
  final CurrentStats currentStats;
  final MaterialConsumption materialConsumption;
  final WeldDuration weldDuration;

  Statistics({
    required this.voltageStats,
    required this.currentStats,
    required this.materialConsumption,
    required this.weldDuration,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      voltageStats: VoltageStats.fromJson(json['voltageStats']),
      currentStats: CurrentStats.fromJson(json['currentStats']),
      materialConsumption:
          MaterialConsumption.fromJson(json['materialConsumption']),
      weldDuration: WeldDuration.fromJson(json['weldDuration']),
    );
  }
}

class VoltageStats {
  final String serial;
  final String model;
  final double avgVoltage;
  final double minVoltage;
  final double maxVoltage;

  VoltageStats({
    required this.serial,
    required this.model,
    required this.avgVoltage,
    required this.minVoltage,
    required this.maxVoltage,
  });

  factory VoltageStats.fromJson(Map<String, dynamic> json) {
    return VoltageStats(
      serial: json['serial'],
      model: json['model'],
      avgVoltage: json['avgVoltage'],
      minVoltage: json['minVoltage'],
      maxVoltage: json['maxVoltage'],
    );
  }
}

class CurrentStats {
  final String serial;
  final String model;
  final double avgCurrent;
  final double minCurrent;
  final double maxCurrent;

  CurrentStats({
    required this.serial,
    required this.model,
    required this.avgCurrent,
    required this.minCurrent,
    required this.maxCurrent,
  });

  factory CurrentStats.fromJson(Map<String, dynamic> json) {
    return CurrentStats(
      serial: json['serial'],
      model: json['model'],
      avgCurrent: json['avgCurrent'],
      minCurrent: json['minCurrent'],
      maxCurrent: json['maxCurrent'],
    );
  }
}

class MaterialConsumption {
  final String serial;
  final String model;
  final TotalMaterialConsumption totalMaterialConsumption;

  MaterialConsumption({
    required this.serial,
    required this.model,
    required this.totalMaterialConsumption,
  });

  factory MaterialConsumption.fromJson(Map<String, dynamic> json) {
    return MaterialConsumption(
      serial: json['serial'],
      model: json['model'],
      totalMaterialConsumption:
          TotalMaterialConsumption.fromJson(json['totalMaterialConsumption']),
    );
  }
}

class TotalMaterialConsumption {
  final double energyConsumptionAsWh;
  final double wireConsumptionInMeters;
  final double fillerConsumptionInGrams;
  final double gasConsumptionInLiters;

  TotalMaterialConsumption({
    required this.energyConsumptionAsWh,
    required this.wireConsumptionInMeters,
    required this.fillerConsumptionInGrams,
    required this.gasConsumptionInLiters,
  });

  factory TotalMaterialConsumption.fromJson(Map<String, dynamic> json) {
    return TotalMaterialConsumption(
      energyConsumptionAsWh: json['energyConsumptionAsWh'],
      wireConsumptionInMeters: json['wireConsumptionInMeters'],
      fillerConsumptionInGrams: json['fillerConsumptionInGrams'],
      gasConsumptionInLiters: json['gasConsumptionInLiters'],
    );
  }
}

class WeldDuration {
  final String serial;
  final String model;
  final TotalWeldDuration totalWeldDuration;

  WeldDuration({
    required this.serial,
    required this.model,
    required this.totalWeldDuration,
  });

  factory WeldDuration.fromJson(Map<String, dynamic> json) {
    return WeldDuration(
      serial: json['serial'],
      model: json['model'],
      totalWeldDuration: TotalWeldDuration.fromJson(json['totalWeldDuration']),
    );
  }
}

class TotalWeldDuration {
  final int preWeldMs;
  final int weldMs;
  final int postWeldMs;
  final int totalMs;

  TotalWeldDuration({
    required this.preWeldMs,
    required this.weldMs,
    required this.postWeldMs,
    required this.totalMs,
  });

  factory TotalWeldDuration.fromJson(Map<String, dynamic> json) {
    return TotalWeldDuration(
      preWeldMs: json['preWeldMs'],
      weldMs: json['weldMs'],
      postWeldMs: json['postWeldMs'],
      totalMs: json['totalMs'],
    );
  }
}
