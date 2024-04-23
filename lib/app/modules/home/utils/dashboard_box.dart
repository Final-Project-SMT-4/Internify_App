import 'package:flutter/material.dart';

class DashboardBox extends StatelessWidget {
  final String itemName;
  final String numberTask;
  final IconData icon;
  final Color color;

  const DashboardBox({
    Key? key,
    required this.itemName,
    required this.numberTask,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 15.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 35,
                        color:
                            Colors.white, // You can customize icon color here
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        itemName,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 3.0,
                top: 12.0,
              ),
              child: Text(
                numberTask,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
