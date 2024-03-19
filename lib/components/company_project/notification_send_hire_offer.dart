import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendHireOfferDialog {
  static void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context)!.dialog_send_hire_offer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
          ),
          content: Text(
              AppLocalizations.of(context)!.confirm__send_hire_offer,
              style: const TextStyle(
                fontSize: 18
              ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
                fixedSize: const Size(130, 40),
              ),
              child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(
                    fontSize: 18,
                  )
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B28C),
                foregroundColor: Colors.black,
                fixedSize: const Size(130, 40),
              ),
              child: Text(
                  AppLocalizations.of(context)!.send,
                  style: const TextStyle(
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
