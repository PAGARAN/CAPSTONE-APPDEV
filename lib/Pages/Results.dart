import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../database/database_helper.dart';
import 'Dashboard.dart';

class Results extends StatelessWidget {
  final String disease;
  final String date;
  final String imagePath;
  final double? confidence;

  const Results({
    Key? key,
    required this.disease,
    required this.date,
    required this.imagePath,
    this.confidence,
  }) : super(key: key);

  Future<void> _deleteDiagnosis(BuildContext context) async {
    final DatabaseHelper dbHelper = DatabaseHelper();
    
    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('confirm_delete'.tr()),
          content: Text('delete_diagnosis_confirmation'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                'delete'.tr(),
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        // Delete the image file if it exists
        if (imagePath.isNotEmpty) {
          final file = File(imagePath);
          if (await file.exists()) {
            await file.delete();
          }
        }

        // Get the diagnosis ID based on date and disease
        final diagnoses = await dbHelper.getDiagnoses();
        final diagnosis = diagnoses.firstWhere(
          (d) => d['date'] == date && d['disease'] == disease,
          orElse: () => {'id': -1},
        );

        if (diagnosis['id'] != -1) {
          await dbHelper.deleteDiagnosis(diagnosis['id']);
        }

        // Navigate back to Dashboard
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (route) => false,
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error_deleting_diagnosis'.tr())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
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
                    Text(
                      disease,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'maize',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Disease Description and Prevention Tips
                    Text(
                      'disease_description'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Dynamically display the correct disease description based on the disease
                    Text(
                      _getDiseaseDescription(disease),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Prevention Tips
                    Text(
                      _getPreventionTitle(disease),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Dynamically display the correct prevention tips based on the disease
                    _buildDiseasePreventionTips(disease),
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

  // Helper method to get the correct disease description based on the disease name
  String _getDiseaseDescription(String disease) {
    switch (disease) {
      case 'Healthy':
        return 'healthy_leaf_description'.tr();
      case 'Common Rust':
        return 'common_rust_description'.tr();
      case 'Gray Leaf Spot':
        return 'gray_leaf_spot_description'.tr();
      case 'Northern Leaf Blight':
        return 'northern_leaf_blight_description'.tr();
      case 'Southern Corn Leaf Blight':
        return 'southern_corn_leaf_blight_description'.tr();
      case 'Blight':
        return 'blight_description'.tr();
      case 'Bacterial Streak':
        return 'bacterial_streak_description'.tr();
      case 'Bacterial Spot':
        return 'bacterial_spot_description'.tr();
      case 'Bacterial Wilt':
        return 'bacterial_wilt_description'.tr();
      case 'Downy Mildew':
        return 'downy_mildew_description'.tr();
      case 'Goss\'s Wilt':
        return 'goss_wilt_description'.tr();
      case 'Maize Dwarf Mosaic':
        return 'maize_dwarf_mosaic_description'.tr();
      case 'Maize Stunt Virus':
        return 'maize_stunt_virus_description'.tr();
      case 'Northern Corn Leaf Blight':
        return 'northern_corn_leaf_blight_description'.tr();
      case 'Northern Corn Leaf Spot':
        return 'northern_corn_leaf_spot_description'.tr();
      case 'Northern Corn Rot':
        return 'northern_corn_rot_description'.tr();
      default:
        return 'common_rust_description'.tr(); // Default fallback
    }
  }

  // Helper method to get the correct prevention title based on the disease name
  String _getPreventionTitle(String disease) {
    switch (disease) {
      case 'Healthy':
        return 'healthy_leaf_prevention'.tr();
      case 'Common Rust':
        return 'disease_prevention'.tr();
      case 'Gray Leaf Spot':
        return 'gray_leaf_spot_prevention'.tr();
      case 'Northern Leaf Blight':
      case 'Northern Corn Leaf Blight':
        return 'northern_leaf_blight_prevention'.tr();
      default:
        return 'disease_prevention'.tr(); // Default fallback
    }
  }

  // Helper method to build the prevention tips based on the disease
  Widget _buildDiseasePreventionTips(String disease) {
    switch (disease) {
      case 'Healthy':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreventionTip(
              'healthy_nutrition_title'.tr(),
              'healthy_nutrition_desc'.tr(),
            ),
            _buildPreventionTip(
              'healthy_irrigation_title'.tr(),
              'healthy_irrigation_desc'.tr(),
            ),
            _buildPreventionTip(
              'healthy_monitoring_title'.tr(),
              'healthy_monitoring_desc'.tr(),
            ),
          ],
        );
      case 'Common Rust':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'fungicide_title'.tr(),
              'fungicide_desc'.tr(),
            ),
          ],
        );
      case 'Gray Leaf Spot':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreventionTip(
              'gls_resistant_varieties_title'.tr(),
              'gls_resistant_varieties_desc'.tr(),
            ),
            _buildPreventionTip(
              'gls_crop_rotation_title'.tr(),
              'gls_crop_rotation_desc'.tr(),
            ),
            _buildPreventionTip(
              'gls_field_sanitation_title'.tr(),
              'gls_field_sanitation_desc'.tr(),
            ),
            _buildPreventionTip(
              'gls_fungicide_title'.tr(),
              'gls_fungicide_desc'.tr(),
            ),
          ],
        );
      case 'Northern Leaf Blight':
      case 'Northern Corn Leaf Blight':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreventionTip(
              'nlb_resistant_varieties_title'.tr(),
              'nlb_resistant_varieties_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_crop_rotation_title'.tr(),
              'nlb_crop_rotation_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_field_sanitation_title'.tr(),
              'nlb_field_sanitation_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_avoid_continuous_title'.tr(),
              'nlb_avoid_continuous_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_fungicide_title'.tr(),
              'nlb_fungicide_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_plant_spacing_title'.tr(),
              'nlb_plant_spacing_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_soil_drainage_title'.tr(),
              'nlb_soil_drainage_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_planting_date_title'.tr(),
              'nlb_planting_date_desc'.tr(),
            ),
            _buildPreventionTip(
              'nlb_specific_fungicides_title'.tr(),
              'nlb_specific_fungicides_desc'.tr(),
            ),
          ],
        );
      default:
        // Default to Common Rust prevention tips
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreventionTip(
              'resistant_varieties_title'.tr(),
              'resistant_varieties_desc'.tr(),
            ),
            _buildPreventionTip(
              'crop_rotation_title'.tr(),
              'crop_rotation_desc'.tr(),
            ),
          ],
        );
    }
  }
}
