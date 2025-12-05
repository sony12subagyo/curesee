import 'package:flutter/material.dart';
import 'features/camera/presentation/widgets/camera_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CureSee")),
      body: Center(
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          panggilHalaman(value);
        },
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromARGB(255, 22, 30, 182),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
        ],
      ),
    );
  }

  void panggilHalaman(int index) {
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
    // } else if (index == 2) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Mahasiswa()));
    // } else if (index == 3) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Matakuliah()));
    // } else if (index == 4) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Nilai()));
    }
  }
}
