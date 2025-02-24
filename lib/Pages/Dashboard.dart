import 'package:flutter/material.dart';
import './Diagnoses.dart';
import './Scan.dart';
import './Results.dart';
import './AboutPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              const SizedBox(height: 32), // Add spacing at the top

              // Row with icon and welcome text
              Row(
                children: [
                  PopupMenuButton(
                    child: Container(
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
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.logout),
                            const SizedBox(width: 8),
                            const Text('language Option'),
                          ],
                        ),
                        onTap: () {
                          // Add a small delay to avoid navigation conflicts
                          Future.delayed(Duration.zero, () {
                            Navigator.pushReplacementNamed(
                                context, '/language');
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 8), // Spacing between icon and text
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5), // Spacing after the welcome row

              // Info Container with overlay
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
                child: Container(
                  height: 211,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
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
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(
                                123, 0, 0, 0), // Semi-transparent background
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                    15)), // Match the image border radius
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
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
              ),

              const SizedBox(height: 5), // Spacing

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
                          const SizedBox(width: 5),
                          const Expanded(
                            child: Text(
                              'Know maize diseases with AI - Powered CDD',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Custom Scan Now Button
                      SizedBox(
                        width: double.infinity, // Full width
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Scan()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black, // Text color
                            side: const BorderSide(
                                color: Colors.black), // Border color
                            padding: const EdgeInsets.symmetric(
                                vertical: 5), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                          ),
                          child: Text('Scan Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5), // Spacing

              // Recent Diagnoses Section with Stroke Design
              Row(
                children: [
                  Image.asset('Assets/images/search.png',
                      height: 14, width: 14),
                  const SizedBox(width: 8),
                  const Text(
                    'Recent Diagnoses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
          if (index == 1) {
            // When scan tab is clicked
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Scan()),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Diagnoses(),
              ),
            );
          }
        },
        elevation: 10,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('Assets/images/Home.png', height: 24, width: 24),
            label: 'Home',
            activeIcon: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF45DFB1),
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
                color: const Color(0xFF45DFB1),
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
                color: const Color(0xFF45DFB1),
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
    return InkWell(
      // Add InkWell for tap functionality
      onTap: () {
        // Navigate to the Result page with the diagnosis details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Results(disease: disease, date: date),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Image.asset(
              'Assets/images/CommonRust.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  disease,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
