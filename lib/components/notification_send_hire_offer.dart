import 'package:flutter/material.dart';

class SendHireOfferDialog {
  static void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              "Hired offer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
          ),
          content: const Text(
              "Do you really want to send hired offer for student to do this project?",
              style: TextStyle(
                fontSize: 18
              ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                onPrimary: Colors.black,
                fixedSize: const Size(130, 40),
              ),
              child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18,
                  )
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF12B28C),
                onPrimary: Colors.black,
                fixedSize: const Size(130, 40),
              ),
              child: const Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 18,
                  )
              ),
            ),
          ],
        );
      },
    );
  }
}
