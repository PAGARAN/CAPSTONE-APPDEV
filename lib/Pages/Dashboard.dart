import 'package:flutter/material.dart';
import './Diagnoses.dart';

class Dashboard extends StatelessWidget {
  // Sample data for recent diagnoses
  final List<Map<String, String>> diagnoses = [
    {'disease': 'Common Rust', 'date': '3h ago'},
    {'disease': 'Common Rust', 'date': 'Nov 4, 2024'},
    {'disease': 'Common Rust', 'date': 'Nov 11, 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE8), // Background color
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32), // Add spacing at the top

              // Row with icon and welcome text
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Image.asset(
                        'Assets/images/Usericon.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Spacing between icon and text
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5), // Spacing after the welcome row

              // Info Container with overlay
              Container(
                height: 211,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  // Use Stack to overlay text on the image
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'Assets/images/FarmImage.png',
                        fit: BoxFit.cover,
                        height: 261,
                        width: 360,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 3,
                      child: Container(
                        width: 343.5,
                        height: 74, // Set height to 74
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              123, 0, 0, 0), // Semi-transparent background
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(
                                  15)), // Match the image border radius
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Learn how Corn Disease Detection helps thousands of farmers',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5), // Spacing

              // Scan Container with Stroke Design
              Container(
                height: 120,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.black, width: 2), // Stroke design
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'Assets/images/scan.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Know maize diseases with AI - Powered CDD',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Custom Scan Now Button
                      Container(
                        width: double.infinity, // Full width
                        child: OutlinedButton(
                          onPressed: () {
                            // Add your scan action here
                          },
                          child: Text('Scan Now'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            side:
                                BorderSide(color: Colors.black), // Border color
                            padding:
                                EdgeInsets.symmetric(vertical: 5), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5), // Spacing

              // Recent Diagnoses Section with Stroke Design
              Row(
                children: [
                  Image.asset('Assets/images/search.png',
                      height: 14, width: 14),
                  SizedBox(width: 8),
                  Text(
                    'Recent Diagnoses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 205, // Adjust height as needed
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: Colors.black, width: 2), // Stroke design
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: List.generate(diagnoses.length, (index) {
                        return _buildDiagnosisItem(
                          diagnoses[index]['disease']!,
                          diagnoses[index]['date']!,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          print('Tapped index: $index'); // Debug print
          if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Diagnoses(),
              ),
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

  Widget _buildDiagnosisItem(String disease, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            'Assets/images/CommonRust.png', // Replace with your image path
            height: 40, // Adjust height as needed
            width: 40, // Adjust width as needed
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disease,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
