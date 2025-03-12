import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './Dashboard.dart';
import './Results.dart';
import './Scan.dart';

class Diagnoses extends StatelessWidget {
  const Diagnoses({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenSize = MediaQuery.of(context).size;
    final double titleSize = screenSize.width * 0.05; // 5% of screen width
    final double subtitleSize = screenSize.width * 0.04; // 4% of screen width
    final double bodySize = screenSize.width * 0.035; // 3.5% of screen width

    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          ),
        ),
        title: AutoSizeText(
          'recent_results'.tr(),
          style: TextStyle(fontSize: titleSize),
          maxLines: 1,
          minFontSize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement export report functionality
            },
            child: AutoSizeText(
              'export_report'.tr(),
              style: TextStyle(fontSize: bodySize),
              maxLines: 1,
              minFontSize: 12,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            screenSize.width * 0.04,
            screenSize.width * 0.04,
            screenSize.width * 0.04,
            screenSize.width * 0.2,
          ),
          children: [
            _buildDiagnosisCard(
              context,
              'rust'.tr(),
              'rust_description'.tr(),
              'assets/images/rustImage.png',
              'just_now'.tr(),
            ),
            _buildDiagnosisCard(
              context,
              'phaeosphaeria'.tr(),
              'phaeosphaeria_description'.tr(),
              'assets/images/phaeosphaeriaImage.png',
              'today'.tr(),
            ),
            _buildDiagnosisCard(
              context,
              'northern_leaf_blight'.tr(),
              'Shows up as long, cigar-shaped lesions. It develops in moderate temps with high humidity. It can quickly spread to impact corn production.',
              'assets/images/northern_leaf_blightImage.png',
              'Yesterday',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildDiagnosisCard(BuildContext context, String title,
      String description, String imagePath, String timeAgo) {
    final screenSize = MediaQuery.of(context).size;
    final double titleSize = screenSize.width * 0.045; // 4.5% of screen width
    final double descriptionSize = screenSize.width * 0.035; // 3.5% of screen width
    final double timeSize = screenSize.width * 0.03; // 3% of screen width
    final double imageHeight = screenSize.height * 0.2; // 20% of screen height

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
        margin: EdgeInsets.only(bottom: screenSize.width * 0.03),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenSize.width * 0.03),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    minFontSize: 14,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  AutoSizeText(
                    description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: descriptionSize,
                    ),
                    maxLines: 3,
                    minFontSize: 12,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  AutoSizeText(
                    timeAgo,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: timeSize,
                    ),
                    maxLines: 1,
                    minFontSize: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double iconSize = screenSize.width * 0.05; // 5% of screen width
    final double fontSize = screenSize.width * 0.03; // 3% of screen width

    return BottomNavigationBar(
      currentIndex: 2,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Scan()),
          );
        }
      },
      elevation: 10,
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: fontSize,
      unselectedFontSize: fontSize,
      iconSize: iconSize,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/Home.png',
              height: iconSize, width: iconSize),
          label: 'home'.tr(),
          activeIcon: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF45DFB1),
              borderRadius: BorderRadius.circular(screenSize.width * 0.025),
            ),
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Image.asset('assets/images/Home.png',
                height: iconSize, width: iconSize),
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ScanNavBar.png',
              height: iconSize, width: iconSize),
          label: 'scan'.tr(),
          activeIcon: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF45DFB1),
              borderRadius: BorderRadius.circular(screenSize.width * 0.025),
            ),
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Image.asset('assets/images/ScanNavBar.png',
                height: iconSize, width: iconSize),
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/DiagnosIcon.png',
              height: iconSize, width: iconSize),
          label: 'diagnoses'.tr(),
          activeIcon: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF45DFB1),
              borderRadius: BorderRadius.circular(screenSize.width * 0.025),
            ),
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Image.asset('assets/images/DiagnosIcon.png',
                height: iconSize, width: iconSize),
          ),
        ),
      ],
    );
  }
}
