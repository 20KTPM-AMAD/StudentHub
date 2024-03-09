import 'package:flutter/material.dart';

class AllProjectsPopupMenu {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 20,),
              SizedBox(
                height: 420,
                child: ListView(
                  physics: const ScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        "View proposals",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        "View messages",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        "View hired",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      title: const Text(
                        "View job posting",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        "Edit posting",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        "Remove posting",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      title: const Text(
                        "Start working this job",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
