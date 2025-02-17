import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './Dashboard.dart';
import 'Results.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        // Navigate to Results with the image
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Results(
              disease: 'Rust',
              date: 'Just now',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF80ED99),
              const Color(0xFF80ED99),
              const Color(0xFF80ED99),
              const Color(0xFF80ED99),
              const Color(0xFF45DFB1),
              const Color(0xFF45DFB1),
              const Color(0xFF0AD1C8),
              const Color(0xFF0AD1C8),
              const Color(0xFF14919B),
              const Color(0xFF0B6477),
              const Color(0xFF213A57),
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
                  margin: EdgeInsets.only(top: 40, bottom: 40),
                  child: Image.asset(
                    'Assets/images/Logo.png',
                    width: 280,
                    height: 280,
                  ),
                ),

                // Pick Gallery Button
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _pickImage(context, ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Pick Gallery',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Pick Camera Button
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _pickImage(context, ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Pick Camera',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
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
