import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class InfoCard extends StatefulWidget {
  const InfoCard({Key? key, required this.title, required this.detail}) : super(key: key);

  final String title;
  final String detail;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis, // Hiển thị "..." nếu title quá dài
                  maxLines: 1, // Giới hạn số dòng hiển thị
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(2),
                    ),
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Text(
            widget.detail,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


