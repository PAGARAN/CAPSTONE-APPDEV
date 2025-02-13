import 'package:flutter/material.dart';
import './Dashboard.dart';
import 'Diagnoses.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8EFE8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8EFE8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Diagnoses()),
          ),
        ),
        title: const Text('Result'),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  'Assets/images/rustImage.png',
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
                          'Rust',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Just Now',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'maize',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Disease Description
                    Text(
                      'Disease Description:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Common rust in maize, caused by Puccinia sorghi, shows as reddish-brown pustules on leaves, affecting photosynthesis and yield, especially in cool, moist climates. Prevent it by using resistant varieties, rotating crops, ensuring good plant spacing, and monitoring for early signs. Fungicides can help if applied promptly, and removing infected residue after harvest minimizes future risk.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Prevention Tips
                    Text(
                      'Prevention Tips:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildPreventionTip(
                      '1. Choose Resistant Varieties:',
                      'Use rust-resistant maize varieties to lower the risk of severe infection and boost natural plant defense.',
                    ),
                    _buildPreventionTip(
                      '2. Rotate Crops:',
                      'Rotate maize with non-host crops like soybeans to disrupt the disease life cycle and reduce spore buildup.',
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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
