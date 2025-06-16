import 'package:flutter/foundation.dart'; // For kDebugMode (optional)

// Helper function to safely parse DateTime, returning null if parsing fails or input is null
DateTime? parseDateTime(String? dateString) {
  if (dateString == null) return null;
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    if (kDebugMode) {
      print('Error parsing date: $dateString, Error: $e');
    }
    return null;
  }
}

// Helper function to safely parse int
int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  if (value is double) return value.toInt(); // Allow conversion from double if applicable
  return null;
}

// Helper function to safely parse double
double? parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

