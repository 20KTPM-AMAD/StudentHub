import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/pages/browse_project/post_project_step_1_screen.dart';

const Color _green = Color(0xff296e48);

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.your_jobs,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PostProjectStep1Screen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: _green,
                          fixedSize: const Size(120, 24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      child: Text(AppLocalizations.of(context)!.post_a_project,
                          style: const TextStyle(fontSize: 14)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.welcome('Hai'),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'You have no jobs!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
    //   ),
    //   bottomNavigationBar: NavigationBar(
    //     height: 60,
    //     destinations: const [
    //       NavigationDestination(icon: Icon(Icons.view_list), label: 'Projects'),
    //       NavigationDestination(
    //         icon: Icon(Icons.home),
    //         label: 'Dashboard',
    //       ),
    //       NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
    //       NavigationDestination(
    //         icon: Icon(Icons.notifications),
    //         label: 'Alerts',
    //       ),
    //     ],
    //     backgroundColor: _green,
    //   ),
    // );
  }
}
