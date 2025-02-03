import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image
              SizedBox(
                height: 379,
                width: 325,
                child: Image.asset('Assets/images/Logo.png', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
