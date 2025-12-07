import 'package:curesee/features/beranda/presentation/widgets/card_page.dart';
import 'package:curesee/features/beranda/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';


class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          CustomHeader(
            title: 'Good Morning Alex',
            subtitle: 'How are you today?',
            extraText: 'ALEXANDER',
            
            avatar: NetworkImage('https://i.pravatar.cc/150?img=3'),
           
          ),

          Expanded(
  child: ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const SizedBox(height: 8),
      const Text('Information Skin Type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

      
      ...List.generate(
        10,
        (index) => Column(
          children: const [
            CardPage(
              image: NetworkImage('https://picsum.photos/id/1015/800/400'),
              
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ],
  ),
),
         
        ],
      ),
    );
  }
}
