import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tanami_capital/config/extensions.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class ResendOtpTimer extends StatefulWidget {
  final int duration; // Countdown duration in seconds
  final Future<void> Function() onResend; // Callback when OTP is resent

  const ResendOtpTimer({
    super.key,
    this.duration = 120, // Default to 120 seconds (2 minutes)
    required this.onResend,
  });

  @override
  State<ResendOtpTimer> createState() => _ResendOtpTimerState();
}

class _ResendOtpTimerState extends State<ResendOtpTimer> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _remainingTime = widget.duration);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendOtp() async {
    if (_remainingTime == 0) {
      await widget.onResend();
      _startTimer(); // Restart the timer
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return context.toArabicNumber(
      '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.h(10)),
          Text(
            _remainingTime > 0
                ? _formatTime(_remainingTime) // Display in MM:SS format
                : context.tr.didntReceiveCode,
            style: TextStyle(
              color: _remainingTime != 0 ? Colors.red : context.appTheme.normal,
              fontSize: 14,
            ),
          ),
          SizedBox(height: context.h(10)),
          if (_remainingTime == 0)
            GestureDetector(
              onTap: () => _resendOtp(),
              child: Text(
                context.tr.resendOtp,
                style: TextStyle(color: context.appTheme.normal, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
