import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakKami extends StatelessWidget {
  const KontakKami({super.key});

  Future<void> _openWhatsapp() async {
    final Uri waUri = Uri.parse(
      "https://chat.whatsapp.com/DjSqyOTaLpODtIE3PzjFd8",
    );
    await launchUrl(waUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kontak Kami",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),

          InkWell(
            child: Row(
              children: const [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 10),
                Text("cureseeapp@gmail.com"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          InkWell(
            onTap: _openWhatsapp,
            child: Row(
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 10),
                Text("+62 813 895 859"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
