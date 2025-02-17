import 'package:flutter/material.dart';
import './Dashboard.dart';
import './Results.dart';

class Diagnoses extends StatelessWidget {
  const Diagnoses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8EFE8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8EFE8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
        title: const Text('Recent Results'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement export report functionality
            },
            child: const Text('Export Report'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDiagnosisCard(
            context,
            'Rust',
            'Common in rust, most conditions, rust appears as orange/brown spots on leaves. Spreads quickly, reducing photosynthesis and yield.',
            'Assets/images/rustImage.png',
            'Just now',
          ),
          _buildDiagnosisCard(
            context,
            'Phaeosphaeria',
            'Caused by Phaeosphaeria maydis length, this disease results in small, brown spots with yellow halos, leading to reduced crop health and browning.',
            'Assets/images/phaeosphaeriaImage.png',
            'Today',
          ),
          _buildDiagnosisCard(
            context,
            'Nothern Leaf Blight',
            'Shows up as long, cigar-shaped lesions. It develops in moderate temps with high humidity. It can quickly spread to impact corn production.',
            'Assets/images/northern_leaf_blightImage.png',
            'Yesterday',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          }
        },
        elevation: 10,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('Assets/images/Home.png', height: 24, width: 24),
            label: 'Home',
            activeIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF45DFB1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child:
                  Image.asset('Assets/images/Home.png', height: 24, width: 24),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('Assets/images/ScanNavBar.png',
                height: 24, width: 24),
            label: 'Scan',
            activeIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF45DFB1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child: Image.asset('Assets/images/ScanNavBar.png',
                  height: 24, width: 24),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('Assets/images/DiagnosIcon.png',
                height: 24, width: 24),
            label: 'Diagnoses',
            activeIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF45DFB1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child: Image.asset('Assets/images/DiagnosIcon.png',
                  height: 24, width: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisCard(BuildContext context, String title,
      String description, String imagePath, String timeAgo) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Results(
            disease: title,
            date: timeAgo,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
