import 'dart:convert';

import 'package:bloom/providers/home_page_provider/category_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart_models/cart_model.dart';
import 'models/cart_models/region_model.dart';
class TestingClass extends StatefulWidget {
  const TestingClass({super.key});

  @override
  State<TestingClass> createState() => _TestingClassState();
}

class _TestingClassState extends State<TestingClass> {
  Cart? cart;
  dynamic error = "Omar";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Region> regions = context.read<CategoryProvider>().regions;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: const Alignment(0, 0),
            child: const Text("Submit" , style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),),
          ),
        ),
        Expanded(child: DataViewer(data: error)),
      ],
    );
  }
}



class DataViewer extends StatelessWidget {
  final dynamic data; // Accepts various data types
  final double textSize;
  final EdgeInsetsGeometry padding;
  final String title;

  const DataViewer({
    super.key,
    required this.data,
    this.textSize = 14.0,
    this.padding = const EdgeInsets.all(16.0),
    this.title = "Formatted Data Viewer",
  });

  /// Formats the input [displayData] for display.
  ///
  /// This method handles different types of data:
  /// 1. Null: Returns "null".
  /// 2. String:
  ///    - If the string is valid JSON (e.g., `http.Response.body` that is JSON, or any JSON string),
  ///      it's parsed and pretty-printed.
  ///    - If the string is not JSON (e.g., normal text, `http.Response.body` that is plain text),
  ///      it's returned as is, with a clarifying note.
  /// 3. Map<String, dynamic> (and other Dart objects):
  ///    - Attempts to convert the object to a JSON string (using `json.encode`, which respects `toJson()` methods).
  ///    - If successful, the resulting JSON is then pretty-printed.
  ///    - If `json.encode` fails (e.g., the object is not directly serializable and lacks a suitable `toJson()` method),
  ///      it falls back to the object's `toString()` method.
  String _formatData(dynamic displayData) {
    try {
      if (displayData == null) {
        return "null";
      }

      // Case 1: Input data is a String.
      // This handles:
      // - Plain text strings.
      // - JSON strings (e.g., from an API like http.Response.body).
      if (displayData is String) {
        try {
          // Attempt to parse and pretty-print if it's a JSON string.
          var decodedJson = json.decode(displayData); // Parses JSON string to Map/List.
          var encoder = const JsonEncoder.withIndent('  '); // 2 spaces for indentation.
          return encoder.convert(decodedJson); // Converts Map/List back to a formatted JSON string.
        } catch (e) {
          // If it's a string but not valid JSON (e.g., plain text, malformed JSON).
          // This path will be taken for "normal Text" or an http.Response.body that isn't JSON.
          return "--- Plain String (or invalid JSON String) ---\n$displayData";
        }
      }
      // Case 2: Input data is NOT a String.
      // This handles:
      // - Map<String, dynamic>.
      // - Lists.
      // - Custom Dart objects (if they have a toJson() method or are otherwise serializable by json.encode).
      else {
        try {
          // Attempt to convert the Dart object to a JSON string, then pretty-print.
          // json.encode will call toJson() on the object if it exists and
          // if toJson() returns a value that json.encode knows how to serialize
          // (e.g., Map, List, String, num, bool, null).
          // This directly handles Map<String, dynamic>.
          String compactJsonString = json.encode(displayData);

          // Now decode this compact JSON string to get a Map/List structure,
          // then re-encode with indent for pretty printing.
          var decodedForPrettyPrint = json.decode(compactJsonString);
          var encoder = const JsonEncoder.withIndent('  ');
          return encoder.convert(decodedForPrettyPrint);
        } catch (e1) {
          // If json.encode(displayData) failed (e.g., object not directly serializable
          // and no suitable toJson() method was found by json.encode).
          // Fall back to the object's toString() method.
          final e1FirstLine = e1.toString().split('\n').first;
          try {
            return "--- Dart Object (fallback to toString(), JSON conversion failed: $e1FirstLine) ---\n${displayData.toString()}";
          } catch (e2) {
            final e2FirstLine = e2.toString().split('\n').first;
            return "Error converting object to string: $e2FirstLine\n(Also failed to convert to JSON: $e1FirstLine)\n\nObject runtimeType: ${displayData.runtimeType}";
          }
        }
      }
    } catch (e) {
      // Catch-all for any unexpected errors during the formatting process.
      final eFirstLine = e.toString().split('\n').first;
      return "An unexpected error occurred while formatting data: $eFirstLine\n\nOriginal data runtimeType: ${displayData.runtimeType}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDataString = _formatData(data);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: SelectableText(
          formattedDataString,
          style: TextStyle(
            fontFamily: 'monospace', // Use a monospaced font for better alignment of JSON/Map data.
            fontSize: textSize,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}




