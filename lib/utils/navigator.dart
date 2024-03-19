import 'package:flutter/material.dart';

class CustomNavigationDestination {
  final Icon icon;
  final String label;

  CustomNavigationDestination({required this.icon, required this.label});
}

class CustomNavigationBar extends StatelessWidget {
  final double height;
  final List<CustomNavigationDestination> destinations;
  final int currentIndex;
  final Color backgroundColor;
  final Function(int) onTap;

  const CustomNavigationBar({
    Key? key,
    required this.height,
    required this.destinations,
    required this.currentIndex,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: destinations.asMap().entries.map((entry) {
          final index = entry.key;
          final destination = entry.value;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: currentIndex == index
                            ? Colors.white.withOpacity(0.7)
                            : Colors.transparent,
                          ),
                      child: destination.icon
                    ),
                  ],
                ),
                Text(
                  destination.label,
                  style: TextStyle(
                    color: currentIndex == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
