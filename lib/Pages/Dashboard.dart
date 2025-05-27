import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './Scan.dart';
import './Results.dart';
import './Diagnoses.dart';
import './AboutPage.dart';
import '../database/database_helper.dart';
import 'dart:io';
import '../widgets/language_selector.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Map<String, dynamic>>> _getRecentDiagnoses() async {
    final dbHelper = DatabaseHelper();
    final diagnoses = await dbHelper.getDiagnoses();
    return diagnoses.take(3).toList(); // Only show last 3 diagnoses
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                                const Icon(Icons.info_outline),
                                SizedBox(width: width * 0.02),
                                Text(
                                  'about_cdd'.tr(),
                                  style: TextStyle(
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.pushNamed(context, '/about');
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: width * 0.02),
                      // Replace Expanded with a Container with constraints
                      Container(
                        constraints: BoxConstraints(maxWidth: width * 0.6),
                        child: Text(
                          'welcome'.tr(), // This is the correct way to use translations
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
                  const LanguageSelector(), // Language selector aligned with welcome text
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width * 0.04),
                    child: Stack(
                      fit: StackFit.expand, // Ensures stack fills the container
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset(
                            'assets/images/FarmImage.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
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
              ),

              SizedBox(height: height * 0.02),

              // Scan Container with Shadow Design
              Container(
                height: scanContainerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(width * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Scan()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: height * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.04),
                              side: BorderSide(
                                color: Colors.black.withOpacity(0.1),
                                width: 1.0,
                              ),
                            ),
                            elevation: 0, // Remove elevation to keep flat design with stroke
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

              // Recent Diagnoses Section with Shadow Design
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _getRecentDiagnoses(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return Column(
                          children: snapshot.data!.map((diagnosis) {
                            return _buildDiagnosisItem(
                              diagnosis['disease'],
                              diagnosis['date'],
                              width,
                            );
                          }).toList(),
                        );
                      },
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
      onTap: () {
        // Get the diagnosis details from the database
        DatabaseHelper().getDiagnoses().then((diagnoses) {
          final diagnosis = diagnoses.firstWhere(
            (d) => d['disease'] == disease && d['date'] == date,
            orElse: () => {'imagePath': '', 'confidence': null}, // Default empty values if not found
          );
          
          // Extract confidence value, defaulting to null if not present
          final confidence = diagnosis['confidence'] != null 
              ? (diagnosis['confidence'] as num).toDouble() 
              : null;
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Results(
                disease: disease,
                date: date,
                imagePath: diagnosis['imagePath'] ?? '',
                confidence: confidence,
              ),
            ),
          );
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: width * 0.02),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.02),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper().getDiagnoses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  final diagnosis = snapshot.data!.firstWhere(
                    (d) => d['disease'] == disease && d['date'] == date,
                    orElse: () => {'imagePath': ''},
                  );
                  
                  return diagnosis['imagePath']?.isNotEmpty == true
                      ? Image.file(
                          File(diagnosis['imagePath']),
                          height: width * 0.1,
                          width: width * 0.1,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/CommonRust.png',
                          height: width * 0.1,
                          width: width * 0.1,
                          fit: BoxFit.cover,
                        );
                },
              ),
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
