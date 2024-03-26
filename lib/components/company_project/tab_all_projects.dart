import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/components/company_project/pop_up_menu_project.dart';
import 'package:studenthub/pages/company_reviews_proposal/send_hire_offer_screen.dart';

const Color _green = Color(0xFF12B28C);

class AllProjectsTab extends StatefulWidget {
  const AllProjectsTab({Key? key}) : super(key: key);

  @override
  AllProjectsTabState createState() => AllProjectsTabState();
}

class AllProjectsTabState extends State<AllProjectsTab> {
  bool isLoading = false;
  int currentPage = 0;
  int itemsPerPage = 2;
  List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMoreItems();
        }
        return true;
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(2.0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
            return Card(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Senior frontend developer (Fintech)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        IconButton(
                          onPressed: () {
                            AllProjectsPopupMenu.show(context);
                          },
                          icon: const Icon(Icons.pending_outlined, size: 30,),
                        ),
                      ],
                    ),
                    Text(
                      AppLocalizations.of(context)!.time_created_project('3'),
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Students are looking for:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '- Clear expectation about your project or deliverables',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.proposals,
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Text(
                              '8',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.messages,
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.hired,
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SendHireOfferScreen()),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _loadMoreItems() {
    setState(() {
      isLoading = true;
    });

    // Simulate a delay for fetching new items
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        int currentLength = items.length;
        for (int i = currentLength; i < currentLength + itemsPerPage; i++) {
          items.add('Item $i');
        }
        isLoading = false;
      });
    });
  }
}
