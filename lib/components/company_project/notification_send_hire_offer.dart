import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';

class SendHireOfferDialog {
  static void showMyDialog(BuildContext context, int proposalId, VoidCallback reloadProposals) {

    Future<void> sendOffer() async {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null){
        final response = await http.patch(
          Uri.parse('http://34.16.137.128/api/proposal/$proposalId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, dynamic>{
            'statusFlag': 2,
            'disableFlag': 0
          }),
        );
        print(response.statusCode);
        print(response.body);

        if(response.statusCode == 200) {
          reloadProposals();  // Reload proposals if the request is successful
        }
      }
    }

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
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16
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
                    fontSize: 16,
                  )
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendOffer();
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
                    fontSize: 16,
                  )
              ),
            ),
          ],
        );
      },
    );
  }
}

