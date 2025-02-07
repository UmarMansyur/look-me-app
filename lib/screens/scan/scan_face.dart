// ignore_for_file: use_build_context_synchronously, unused_field, constant_identifier_names, non_constant_identifier_names

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:http/http.dart' as http;

class ScanFace extends StatefulWidget {
  const ScanFace({super.key});

  @override
  State<ScanFace> createState() => _ScanFaceState();
}

class _ScanFaceState extends State<ScanFace> {
  String _currentInstruction = 'Kedipkan Mata 2x';
  final int _currentStep = 0;

  final Map<String, dynamic> _faceDataComplete = {
    'measurements': [],
    'blinks': [],
    'timestamps': [],
  };

  static const double MIN_FACE_SIZE = 150.0;
  static const double MAX_FACE_SIZE = 180.0;

  String _faceDistanceStatus = '';
  Color _statusColor = Colors.red;
  double _currentFaceDistance = 0.0;
  void _checkFaceDistance(Face face) {
    final screenSize = MediaQuery.of(context).size;
    final previewSize = screenSize.width * 0.7;

    _currentFaceDistance = face.boundingBox.width;

    final scale = _getCameraScale(previewSize);
    final scaledWidth = face.boundingBox.width * scale;

  
    final MIN_SCALED_SIZE = MIN_FACE_SIZE * scale;
    final MAX_SCALED_SIZE = MAX_FACE_SIZE * scale;

    setState(() {
      if (scaledWidth < MIN_SCALED_SIZE) {
        _faceDistanceStatus = 'Terlalu Jauh! Mohon mendekat';
        _statusColor = Colors.red;
        _isFaceDetected = false;
      } else if (scaledWidth > MAX_SCALED_SIZE) {
        _faceDistanceStatus = 'Terlalu Dekat! Mohon menjauh';
        _statusColor = Colors.red;
        _isFaceDetected = false;
      } else {
        _faceDistanceStatus = 'Jarak Sudah Tepat, Silahkan Kedipkan Mata Anda!';
        _statusColor = const Color(0xFF2CD097);
        _isFaceDetected = true;
      }
    });
  }

  bool _isLoading = true;
  CameraController? _cameraController;
  FaceDetector? _faceDetector;
  bool _isFaceDetected = false;
  Rect? _faceRect;
  int _blinkCount = 0;
  bool _isProcessingBlink = false;

  final Queue<Face> _faceQueue = Queue<Face>();
  static const int maxQueueSize = 10;

  Map<String, dynamic>? _existingFaceData;
  bool _isComparingFace = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeFaceDetector();
    _checkExistingFaceData();
  }

  void _initializeFaceDetector() {
    final options = FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: true,
      performanceMode: FaceDetectorMode.accurate,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> _checkExistingFaceData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api2.sinikendp.com/faceku'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _existingFaceData = data;
          _isComparingFace = true;
        });
      }
    } catch (e) {
      _handleError('Error fetching face data: $e');
    }
  }

  Future<void> _saveFaceData() async {
    try {
      final jsonData = jsonEncode({
        'measurements': _faceDataComplete['measurements'],
      });

      final bodyData = {
        'data': jsonData,
        if (_isComparingFace) 'existingData': _existingFaceData,
      };

      final endpoint = _isComparingFace ? '/compare' : '/';
      final response = await http.post(
        Uri.parse('https://api2.sinikendp.com$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );

      final data = jsonDecode(response.body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${data['message']}',
            ),
            backgroundColor: data['status'] == 'success'
                ? const Color(0xFF2CD097)
                : Colors.red,
          ),
        );

        await _cameraController?.stopImageStream();
        await _cameraController?.dispose();
        await _faceDetector?.close();
        Navigator.of(context).pop();
      }
    } catch (e) {
      _handleError('Error processing face data: $e');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(
      front,
      ResolutionPreset.low,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() => _isLoading = false);
    }

    int frameSkip = 0;
    _cameraController!.startImageStream((image) {
      frameSkip++;
      if (frameSkip % 10 == 0) {
        _processCameraImage(image);
      }
    });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_faceQueue.length >= maxQueueSize) {
      _faceQueue.clear();
    }

    if (_isProcessingBlink) return;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(image.width.toDouble(), image.height.toDouble());
      final camera = _cameraController!.description;
      final imageRotation =
          InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
              InputImageRotation.rotation0deg;

      final platform = defaultTargetPlatform;

      InputImageFormat inputImageFormat;

      if (platform == TargetPlatform.android) {
        inputImageFormat = InputImageFormat.nv21;
      } else if (platform == TargetPlatform.iOS) {
        inputImageFormat = InputImageFormat.bgra8888;
      } else {
        throw Exception('Unsupported platform');
      }

      final inputImageData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: inputImageData,
      );

      final faces = await _faceDetector!.processImage(inputImage);

      if (!mounted) return;

      if (faces.isNotEmpty) {
        final face = faces.first;
        _faceQueue.add(face);

        _storeFaceData(face);
        _checkFaceDistance(face);
        setState(() {
          _isFaceDetected = true;
          _faceRect = face.boundingBox;
        });

        if (_currentStep == 0 && _isFaceDetected && _faceDistanceStatus == 'Jarak Sudah Tepat!' && _detectBlink(face)) {
          await _handleBlinkDetection();
        }
      } else {
        setState(() {
          _isFaceDetected = false;
          _faceRect = null;
          _faceDistanceStatus = 'Wajah tidak ditemukan';
          _statusColor = Colors.red;
        });
      }
    } catch (e) {
      _handleError('Image processing error: $e');
    }
  }

  void _storeFaceData(Face face) {
    _faceDataComplete['measurements'].add({
      'boundingBox': {
        'left': face.boundingBox.left,
        'top': face.boundingBox.top,
        'width': face.boundingBox.width,
        'height': face.boundingBox.height,
      },
      'landmarks': face.landmarks.entries
          .map((entry) => {
                'type': entry.key.toString(),
                'x': entry.value?.position.x ?? 0,
                'y': entry.value?.position.y ?? 0,
              })
          .toList(),
      'headEulerAngleX': face.headEulerAngleX,
      'headEulerAngleY': face.headEulerAngleY,
      'headEulerAngleZ': face.headEulerAngleZ,
      'leftEyeOpen': face.leftEyeOpenProbability,
      'rightEyeOpen': face.rightEyeOpenProbability,
    });
    _faceDataComplete['timestamps'].add(DateTime.now().toIso8601String());
  }

  bool _detectBlink(Face face) {
    final leftEyeOpen = face.leftEyeOpenProbability ?? 0;
    final rightEyeOpen = face.rightEyeOpenProbability ?? 0;

    // Ubah threshold menjadi lebih presisi
    const double BLINK_THRESHOLD = 0.2;
    const double MIN_EYE_DIFF = 0.1;

    final averageEyeOpen = (leftEyeOpen + rightEyeOpen) / 2;
    final eyeDifference = (leftEyeOpen - rightEyeOpen).abs();

    // Tambah validasi perbedaan kedua mata
    return averageEyeOpen < BLINK_THRESHOLD &&
        eyeDifference < MIN_EYE_DIFF &&
        !_isProcessingBlink;
  }

  Future<void> _handleBlinkDetection() async {
    if (_isProcessingBlink) return;

    _isProcessingBlink = true;
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (_faceQueue.isNotEmpty) {
        final currentFace = _faceQueue.last;
        final leftEyeOpen = currentFace.leftEyeOpenProbability ?? 0;
        final rightEyeOpen = currentFace.rightEyeOpenProbability ?? 0;
        final averageEyeOpen = (leftEyeOpen + rightEyeOpen) / 2;

        const double CONFIRMATION_THRESHOLD = 0.25;

        if (averageEyeOpen < CONFIRMATION_THRESHOLD && mounted) {
          setState(() {
            _blinkCount++;
          });

          _currentInstruction = 'Kedipkan Mata 1x lagi!';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kedipan $_blinkCount terdeteksi, Silahkan Kedipkan Mata Anda Kembali!'),
              duration: const Duration(milliseconds: 500),
              backgroundColor: const Color(0xFF2CD097),
            ),
          );

          _faceDataComplete['blinks'].add({
            'timestamp': DateTime.now().toIso8601String(),
            'count': _blinkCount,
            'leftEyeValue': leftEyeOpen,
            'rightEyeValue': rightEyeOpen,
            'averageValue': averageEyeOpen,
          });

          if (_blinkCount >= 2) {
            await _saveFaceData();
          }
        }
      }
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      _isProcessingBlink = false;
    }
  }

  void _handleError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Memuat Kamera...'),
            ],
          ),
        ),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final previewSize = screenSize.width * 0.7;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Letakkan Wajah anda di dalam Lingkaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: previewSize,
                      height: previewSize,
                      child: ClipOval(
                        child: Transform.scale(
                          scale: _getCameraScale(previewSize),
                          child: Center(
                            child: CameraPreview(_cameraController!),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: previewSize,
                      height: previewSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: !_isFaceDetected ? Colors.red : Colors.green,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    if (_faceRect != null && _isFaceDetected)
                      SizedBox(
                        width: previewSize,
                        height: previewSize,
                        child: ClipOval(
                          child: CustomPaint(
                            painter: FaceBoxPainter(
                              _faceRect!,
                              _cameraController!.value.aspectRatio,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    _currentInstruction,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _faceDistanceStatus,
                    style: TextStyle(
                      fontSize: 18,
                      color: _statusColor,
                    ),
                  ),
                  Text(
                    'Jarak Wajah: $_currentFaceDistance',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getCameraScale(double previewSize) {
    if (_cameraController == null) return 1.0;

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final cameraRatio = _cameraController!.value.aspectRatio;

    double scale = 1.0;
    if (cameraRatio > deviceRatio) {
      scale = previewSize / (size.width / cameraRatio);
    } else {
      scale = previewSize / size.width;
    }

    return scale * 1.5;
  }
}

class FaceBoxPainter extends CustomPainter {
  final Rect rect;
  final double cameraAspectRatio;

  FaceBoxPainter(this.rect, this.cameraAspectRatio);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = const Color(0xFF2CD097);

    final scaleX = size.width;
    final scaleY = size.height;

    final scaledRect = Rect.fromLTWH(
      size.width - (rect.left * scaleX),
      rect.top * scaleY,
      rect.width * scaleX,
      rect.height * scaleY,
    );

    canvas.drawRect(scaledRect, paint);
  }

  @override
  bool shouldRepaint(FaceBoxPainter oldDelegate) => true;
}
