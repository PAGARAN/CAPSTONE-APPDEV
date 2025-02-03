import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE8), // Background color
      body: SingleChildScrollView(
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

              SizedBox(height: 16), // Spacing after the welcome row

              // Info Container
              Container(
                height: 261,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF), // Example background color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Image.asset(   
                  'Assets/Images/FarmerImage.png',
                  fit: BoxFit.contain,
                  height: 261,
                  width: 350,
                )),
              ),

              SizedBox(height: 16), // Spacing

              // Scan Container
              Container(
                height: 104,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(height: 16), // Spacing

              //Recent Diagnose Container
              Container(
                height: 241,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
