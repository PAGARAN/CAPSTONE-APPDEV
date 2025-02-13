import 'package:flutter/material.dart';
import './Dashboard.dart';

class Diagnoses extends StatelessWidget {
  const Diagnoses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
            'Rust',
            'Common in rust, most conditions, rust appears as orange/brown spots on leaves. Spreads quickly, reducing photosynthesis and yield.',
            'assets/images/rust.jpg',
            'Just now',
          ),
          _buildDiagnosisCard(
            'Phaeosphaeria',
            'Caused by Phaeosphaeria maydis length, this disease results in small, brown spots with yellow halos, leading to reduced crop health and browning.',
            'assets/images/phaeosphaeria.jpg',
            'Today',
          ),
          _buildDiagnosisCard(
            'Nothern Leaf Blight',
            'Shows up as long, cigar-shaped lesions. It develops in moderate temps with high humidity. It can quickly spread to impact corn production.',
            'assets/images/northern_leaf_blight.jpg',
            'Yesterday',
          ),
          _buildDiagnosisCard(
            'Southern Leaf Blight',
            'A warm-weather disease. It creates tan, oval lesions with dark borders. Can spread quickly and severely hurt corn production.',
            'assets/images/southern_leaf_blight.jpg',
            'Three days ago',
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon:
                  Image.asset('Assets/images/Home.png', height: 24, width: 24),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('Assets/images/ScanNavBar.png',
                  height: 24, width: 24),
              onPressed: () {
                // TODO: Implement fullscreen functionality
              },
            ),
            IconButton(
              icon: Image.asset('Assets/images/DiagnosIcon.png',
                  height: 24, width: 24),
              onPressed: () {
                // TODO: Implement share functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisCard(
      String title, String description, String imagePath, String timeAgo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
    );
  }
}
