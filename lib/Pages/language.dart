import 'package:flutter/material.dart';
import './Dashboard.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF80ED99),
              Color(0xFF80ED99),
              Color(0xFF80ED99),
              Color(0xFF80ED99),
              Color(0xFF45DFB1),
              Color(0xFF45DFB1),
              Color(0xFF0AD1C8),
              Color(0xFF0AD1C8),
              Color(0xFF14919B),
              Color(0xFF0B6477),
              Color(0xFF213A57),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                  child: Image.asset(
                    'Assets/images/Logo.png',
                    width: 280,
                    height: 280,
                  ),
                ),

                // Bisaya Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Bisaya',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                // Tagalog Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Tagalog',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                // Cebuano Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'English',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
