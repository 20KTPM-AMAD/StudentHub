import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/components/student_project/student_project_detail_card.dart';

const Color _green = Color(0xFF12B28C);

class StudentAllProjectsTab extends StatefulWidget {
  const StudentAllProjectsTab({Key? key}) : super(key: key);

  @override
  StudentAllProjectsTabState createState() => StudentAllProjectsTabState();
}

class StudentAllProjectsTabState extends State<StudentAllProjectsTab> {
  bool isLoading = false;
  int currentPage = 0;
  int itemsPerPage = 5;
  List<String> items = List.generate(5, (index) => 'Item $index');

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: _green, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.submitted_notification('3'),
                        style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return StudentProjectDetailCard();
                    },
                  ),
                  if (isLoading) _buildProgressIndicator(),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: _green, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.submitted_notification('3'),
                        style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return StudentProjectDetailCard();
                    },
                  ),
                  if (isLoading) _buildProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
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
