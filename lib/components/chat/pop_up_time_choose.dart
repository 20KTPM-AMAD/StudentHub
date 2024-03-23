import 'package:flutter/material.dart';
import 'package:studenthub/components/input_group.dart';
import 'package:studenthub/components/company_project/radio_button_group_project_length.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class TimeChoosePopupFilter {

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Text(
                        'Schedule a video call interview',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    InputGroup(name: 'Title'),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start time',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const Text(
                              'Choose start time: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month_outlined))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End time',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Choose end time: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month_outlined)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration: 60 minutes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.black,
                            ),
                            child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(fontSize: 18)),
                          ),
                          ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _green,
                                foregroundColor: Colors.black
                            ),
                            child: Text('Send Invite', style: const TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
