import 'dart:async';

import 'package:bloom/constants.dart';
import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final String endAt;

  const CountdownTimerWidget({super.key, required this.endAt});

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  Timer? _timer;
  late DateTime _targetDate;
  Duration _timeRemaining = Duration.zero;
  bool _countdownHasFinished = false;

  @override
  void initState() {
    super.initState();
    try {
      _targetDate = DateTime.parse(widget.endAt);
    } catch (e) {
      // Handle invalid date format string if necessary
      // For now, default to a time in the past to show finished state
      _targetDate = DateTime.now().subtract(const Duration(seconds: 1));
      print("Error parsing endAt date: ${widget.endAt}. Defaulting to past date.");
    }
    _initializeTimer();
  }

  void _initializeTimer() {
    // Calculate initial remaining time
    _updateRemainingTime();

    // Start timer only if target date is in the future
    if (_targetDate.isAfter(DateTime.now())) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateRemainingTime();
      });
    } else {
      // If target date is already in the past, set as finished
      if (mounted) {
        setState(() {
          _countdownHasFinished = true;
          _timeRemaining = Duration.zero; // Ensure it shows all zeros
        });
      }
    }
  }

  void _updateRemainingTime() {
    if (!mounted) return; // Exit if the widget is no longer in the tree

    final now = DateTime.now();
    if (_targetDate.isAfter(now)) {
      setState(() {
        _timeRemaining = _targetDate.difference(now);
        _countdownHasFinished = false;
      });
    } else {
      setState(() {
        _timeRemaining = Duration.zero; // Ensure clean zero display
        _countdownHasFinished = true;
        _timer?.cancel(); // Stop the timer
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Important to cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int days, hours, minutes, seconds;

    if (_countdownHasFinished) {
      days = 0;
      hours = 0;
      minutes = 0;
      seconds = 0;
    } else {
      days = _timeRemaining.inDays;
      hours = _timeRemaining.inHours % 24;
      minutes = _timeRemaining.inMinutes % 60;
      seconds = _timeRemaining.inSeconds % 60;
    }

    // For debugging or to show a message when finished:
    // if (_countdownHasFinished) {
    //   return Center(child: Text("The event has started/ended!", style: TextStyle(fontSize: 18)));
    // }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space like in the image
        children: [
          _buildTimeUnit(days.toString().padLeft(2, '0'), "Days"),
          _buildTimeUnit(hours.toString().padLeft(2, '0'), "Hours"),
          _buildTimeUnit(minutes.toString().padLeft(2, '0'), "Minutes"),
          _buildTimeUnit(seconds.toString().padLeft(2, '0'), "Seconds"),
        ],
      ),
    );
  }

  // Helper widget to build each time unit (e.g., Days, Hours)
  Widget _buildTimeUnit(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min, // So the column doesn't take unnecessary space
      children: [
        Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(defaultPadding /2),
          alignment: const Alignment(0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16, // Adjust font size as needed
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Space between the number box and the label
        Container(
          padding: const EdgeInsets.all(defaultPadding /4),
          color: Colors.white54,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }
}