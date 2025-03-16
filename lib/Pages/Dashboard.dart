import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './Diagnoses.dart';
import './Scan.dart';
import './Results.dart';
import './AboutPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Sample data for recent diagnoses
  final List<Map<String, String>> diagnoses = [
    {'disease': 'Common Rust'.tr(), 'date': '3h_ago'.tr()},
    {'disease': 'Common Rust'.tr(), 'date': 'Nov_4_2024'.tr()},
    {'disease': 'Common Rust'.tr(), 'date': 'Nov_11_2024'.tr()},
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final height = screenSize.height - padding.top - padding.bottom;
    final width = screenSize.width;

    // Calculate responsive dimensions
    final containerWidth = width * 0.9; // 90% of screen width
    final imageHeight = height * 0.25; // 25% of available height
    final scanContainerHeight = height * 0.17; // Increased from 0.15 to 0.17 (17% of available height)
    final diagnosesHeight = height * 0.3; // 30% of available height

    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE8), // Background color
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, // 4% padding
            vertical: height * 0.02, // 2% padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04), // 4% spacing

              // User Profile and Welcome Text
              Row(
                children: [
                  PopupMenuButton(
                    child: Container(
                      height: width * 0.1, // Responsive size
                      width: width * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(width * 0.05),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Usericon.png',
                          height: width * 0.06,
                          width: width * 0.06,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.language), // Changed to language icon for better context
                            SizedBox(width: width * 0.02),
                            Text(
                              'language'.tr(),
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Add a small delay to avoid navigation conflicts
                          Future.delayed(Duration.zero, () {
                            Navigator.pushReplacementNamed(context, '/language');
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: Text(
                      'welcome'.tr(),
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // Info Container with overlay
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
                child: Container(
                  height: imageHeight,
                  width: containerWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.04),
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
                        borderRadius: BorderRadius.circular(width * 0.04),
                        child: Image.asset(
                          'assets/images/FarmImage.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: imageHeight * 0.35,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(width * 0.04),
                            ),
                          ),
                          padding: EdgeInsets.all(width * 0.02),
                          child: AutoSizeText(
                            'learn_how_cdd_helps'.tr(),
                            style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            minFontSize: 10,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // Scan Container with Stroke Design
              Container(
                height: scanContainerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(width * 0.04),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/scan.png',
                            height: width * 0.05,
                            width: width * 0.05,
                          ),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: Text(
                              'know_maize_diseases'.tr(),
                              style: TextStyle(fontSize: width * 0.035),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Scan()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black, width: 2.2),
                            padding: EdgeInsets.symmetric(vertical: height * 0.015), // Back to original larger padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.04),
                            ),
                          ),
                          child: Text(
                            'scan_now'.tr(),
                            style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // Recent Diagnoses Section with Stroke Design
              Row(
                children: [
                  Image.asset(
                    'assets/images/search.png',
                    height: width * 0.04,
                    width: width * 0.04,
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: AutoSizeText(
                      'recent_diagnoses'.tr(),
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 12,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Container(
                height: diagnosesHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(width * 0.06),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Column(
                      children: diagnoses.map((diagnosis) {
                        return _buildDiagnosisItem(
                          diagnosis['disease']!,
                          diagnosis['date']!,
                          width,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(width),
    );
  }

  Widget _buildDiagnosisItem(String disease, String date, double width) {
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
        padding: EdgeInsets.symmetric(vertical: width * 0.02),
        child: Row(
          children: [
            Image.asset(
              'assets/images/CommonRust.png',
              height: width * 0.1,
              width: width * 0.1,
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    disease,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 10,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    date,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey,
                    ),
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(double width) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Scan()),
          );
        } else if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Diagnoses()),
          );
        }
      },
      elevation: 10,
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: width * 0.025,
      unselectedFontSize: width * 0.025,
      iconSize: width * 0.05,
      items: [
        _buildNavigationBarItem('Home', 'home', width),
        _buildNavigationBarItem('ScanNavBar', 'scan', width),
        _buildNavigationBarItem('DiagnosIcon', 'diagnose', width),
      ],
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String iconName, String label, double width) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/images/$iconName.png',
        height: width * 0.05,
        width: width * 0.05,
      ),
      label: label.tr(),
      activeIcon: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF45DFB1),
          borderRadius: BorderRadius.circular(width * 0.025),
        ),
        padding: EdgeInsets.all(width * 0.02),
        child: Image.asset(
          'assets/images/$iconName.png',
          height: width * 0.05,
          width: width * 0.05,
        ),
      ),
    );
  }
}
