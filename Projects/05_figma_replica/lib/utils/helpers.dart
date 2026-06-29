import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static String firebaseError(dynamic error) {
    return error
        .toString()
        .replaceAll('[firebase_auth/', '')
        .replaceAll(']', '');
  }
}
