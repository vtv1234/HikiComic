import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hikicomic/utils/colors.dart';

Flushbar infoSnakBar({required String info, required int duration}) {
  return Flushbar(
      // title: 'Information',
      messageText: Text(
        info,
        maxLines: 4,
      ),
      duration: Duration(seconds: duration),
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.blueAccent,
      icon: const Icon(Icons.info_outline),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8));
}

Flushbar warningSnakBar({required String warning, required int duration}) {
  return Flushbar(
      //title: 'Information',
      messageText: Text(
        warning,
        maxLines: 4,
      ),
      duration: Duration(seconds: duration),
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.amber,
      icon: const Icon(Icons.warning_outlined),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8));
}

Flushbar errorSnakBar({required String error, required int duration}) {
  return Flushbar(
      //title: 'Information',
      messageText: Text(
        error,
        maxLines: 4,
      ),
      duration: Duration(seconds: duration),
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: kRed,
      icon: const Icon(Icons.error_outline),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8));
}

Flushbar successSnakBar({required String success, required int duration}) {
  return Flushbar(
      //title: 'Information',
      messageText: Text(
        success,
        maxLines: 4,
      ),
      duration: Duration(seconds: duration),
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle_outline),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8));
}
