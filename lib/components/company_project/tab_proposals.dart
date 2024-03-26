import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'notification_send_hire_offer.dart';

const Color _green = Color(0xFF12B28C);

class ProposalsTab extends StatefulWidget {
  const ProposalsTab({Key? key}) : super(key: key);

  @override
  ProposalsTabState createState() => ProposalsTabState();
}

class ProposalsTabState extends State<ProposalsTab> {
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
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
                    const Row(
                      children: [
                        Icon(
                          Icons.person_4,
                          size: 100,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hung Le',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '4th year student',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fullstack Engineer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Excellent',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'I have gone through your project and it seem like a great project. I will commit for your project...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.black,
                            fixedSize: const Size(130, 40),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.message,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            SendHireOfferDialog.showMyDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.black,
                            fixedSize: const Size(130, 40),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.send_hired_offer,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () {},
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
