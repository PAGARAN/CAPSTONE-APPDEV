import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ModelService {
  static const String modelPath = 'assets/models/best_int8.tflite';
  static const int inputSize = 640; // YOLOv8 typically uses 640x640

  late Interpreter _interpreter;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final appDir = await getApplicationDocumentsDirectory();
    final modelFile = File('${appDir.path}/best_int8.tflite');

    if (!await modelFile.exists()) {
      final modelData = await rootBundle.load(modelPath);
      await modelFile.writeAsBytes(modelData.buffer.asUint8List());
    }

    _interpreter = await Interpreter.fromFile(modelFile);
    _isInitialized = true;
  }

  Future<Map<String, dynamic>> detectDisease(File imageFile) async {
    if (!_isInitialized) await initialize();

    final imageBytes = await imageFile.readAsBytes();
    var image = img.decodeImage(imageBytes)!;
    var resizedImage =
        img.copyResize(image, width: inputSize, height: inputSize);

    var inputTensor = List.generate(
      inputSize,
      (y) => List.generate(
        inputSize,
        (x) {
          final pixel = resizedImage.getPixel(x, y);
          return [
            pixel.r / 255.0,
            pixel.g / 255.0,
            pixel.b / 255.0,
          ];
        },
      ),
    );

    var outputShape = [1, 3]; // Adjust based on your model's output shape
    var output =
        List.filled(outputShape[0] * outputShape[1], 0.0).reshape(outputShape);

    _interpreter.run(inputTensor, output);

    String predictedDisease = "Healthy";
    double confidence = 0.0;
    List<Map<String, dynamic>> detections = [];

    if (output[0][0] > 0.5) {
      predictedDisease = "Common Rust";
      confidence = output[0][0];
    } else if (output[0][1] > 0.5) {
      predictedDisease = "Northern Leaf Blight";
      confidence = output[0][1];
    } else if (output[0][2] > 0.5) {
      predictedDisease = "Gray Leaf Spot";
      confidence = output[0][2];
    }

    return {
      'disease': predictedDisease,
      'confidence': confidence,
      'detections': detections,
    };
  }

  void dispose() {
    if (_isInitialized) {
      _interpreter.close();
    }
  }
}
