import 'package:flutter/material.dart';

class TotalScanCard extends StatelessWidget {
  const TotalScanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16), // biar tidak mepet
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // RATa KIRI
          children: const [
            Row(
              children: [
                Icon(Icons.analytics),
                Text(
                  '3',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('Total Scan', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
