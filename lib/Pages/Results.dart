import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Diagnoses.dart';
import 'dart:io';

class Results extends StatelessWidget {
  final String disease;
  final String date;
  final String imagePath;
  final double confidence; // Add this parameter

  const Results({
    Key? key,
    required this.disease,
    required this.date,
    required this.imagePath,
    this.confidence = 0.0, // Default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Diagnoses()),
          ),
        ),
        title: Text('result'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Disease Image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.file(
                  File(imagePath),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              // Disease Title and Type
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          disease,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'maize',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Disease Description
                    Text(
                      'disease_description'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'common_rust_description'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Prevention Tips
                    Text(
                      'disease_prevention'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildPreventionTip(
                      'resistant_varieties_title'.tr(),
                      'resistant_varieties_desc'.tr(),
                    ),
                    _buildPreventionTip(
                      'crop_rotation_title'.tr(),
                      'crop_rotation_desc'.tr(),
                    ),
                    _buildPreventionTip(
                      '3. Optimize Plant Spacing:',
                      'Plant maize with enough spacing to improve airflow, reducing leaf moisture and fungal infection risks.',
                    ),
                    _buildPreventionTip(
                      '4. Monitor Regularly:',
                      'Regularly inspect crops, especially during moist conditions, for early detection.',
                    ),
                    _buildPreventionTip(
                      '5. Apply Fungicides if Needed:',
                      'Apply fungicides early if rust appears, following local guidelines for correct fungicide selection and timing.',
                    ),
                    _buildPreventionTip(
                      '6. Remove Infected Residue:',
                      'After harvest, clear infected residue to reduce fungal spores and lower future crop infection chances.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreventionTip(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
