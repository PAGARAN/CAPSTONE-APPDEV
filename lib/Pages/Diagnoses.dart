import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/database_helper.dart';
import 'Results.dart';

class Diagnoses extends StatefulWidget {
  const Diagnoses({Key? key}) : super(key: key);

  @override
  State<Diagnoses> createState() => _DiagnosesState();
}

class _DiagnosesState extends State<Diagnoses> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('diagnoses'.tr()),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _databaseHelper.getDiagnoses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('no_diagnoses'.tr()));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final diagnosis = snapshot.data![index];
              final imagePath = diagnosis['image_path'];
              final disease = diagnosis['disease'];
              final date = DateTime.parse(diagnosis['date']);
              final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: imagePath != null
                        ? Image.file(File(imagePath), fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported),
                  ),
                  title: Text(disease),
                  subtitle: Text(formattedDate),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Results(
                          disease: disease,
                          date: diagnosis['date'],
                          imagePath: imagePath,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
