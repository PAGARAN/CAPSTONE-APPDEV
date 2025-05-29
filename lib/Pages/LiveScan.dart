import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../services/model_service.dart';
import './Results.dart';
import '../database/database_helper.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class LiveScanPage extends StatefulWidget {
  final CameraDescription camera;
  final ModelService modelService;

  const LiveScanPage({
    Key? key,
    required this.camera,
    required this.modelService,
  }) : super(key: key);

  @override
  _LiveScanPageState createState() => _LiveScanPageState();
}

class _LiveScanPageState extends State<LiveScanPage> with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isAnalyzing = false;
  int _frameSkip = 0;
  bool _isCameraInitialized = false;
  
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    _startImageStream();
  }
  
  void _startImageStream() async {
    try {
      await _initializeControllerFuture;
      setState(() {
        _isCameraInitialized = true;
      });
      
      // Use a timer instead of image stream for more control
      const duration = Duration(milliseconds: 1000); // Process every second
      Timer.periodic(duration, (timer) async {
        if (!mounted || _isAnalyzing) return;
        
        _isAnalyzing = true;
        try {
          // Capture and process a single frame
          final imageFile = await _convertImageToFile(await _controller.takePicture() as CameraImage);
          
          // Process with model
          final results = await widget.modelService.detectDisease(imageFile);
          final double confidence = results['confidence'] ?? 0.0;
          
          // If confidence is high enough, save and show results
          if (confidence > 0.7 && mounted) {
            timer.cancel(); // Stop processing
            
            final dbHelper = DatabaseHelper();
            final imagePath = await dbHelper.saveImage(imageFile);
            
            await dbHelper.insertDiagnosis(
              results['disease'],
              imagePath,
              confidence
            );
            
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Results(
                    disease: results['disease'],
                    date: DateTime.now().toIso8601String(),
                    imagePath: imagePath,
                    confidence: confidence,
                  ),
                ),
              );
            }
          }
        } catch (e) {
          print('Error in frame processing: $e');
        } finally {
          _isAnalyzing = false;
        }
      });
    } catch (e) {
      print('Error starting image stream: $e');
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }
  
  // Helper method to convert CameraImage to File
  Future<File> _convertImageToFile(CameraImage image) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      // Take a screenshot of the current camera preview
      if (!_controller.value.isInitialized) {
        throw Exception("Camera not initialized");
      }
      
      // Instead of trying to convert the CameraImage directly, 
      // capture the current frame from the preview
      final imageBytes = await _controller.takePicture();
      
      // Copy the captured image to our temp file
      final bytes = await imageBytes.readAsBytes();
      await tempFile.writeAsBytes(bytes);
      
      print("Image saved to: ${tempFile.path}");
      print("Image size: ${await tempFile.length()} bytes");
      
      return tempFile;
    } catch (e) {
      print('Error converting image: $e');
      rethrow; // Rethrow to handle in the calling method
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('live_scan'.tr()),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && _isCameraInitialized) {
            // Camera is initialized, show preview
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'scanning_for_diseases'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Add a scanning indicator
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _isAnalyzing
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(Icons.camera, color: Colors.white),
                  ),
                ),
              ],
            );
          } else {
            // Camera is initializing, show loading indicator
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'initializing_camera'.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}








