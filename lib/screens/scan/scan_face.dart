import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ScanFace extends StatefulWidget {
  const ScanFace({super.key});

  @override
  State<ScanFace> createState() => _ScanFaceState();
}

class _ScanFaceState extends State<ScanFace> {
  bool _isLoading = true;
  CameraController? _cameraController;
  FaceDetector? _faceDetector;
  bool _isFaceDetected = false;
  bool _isBlinking = false;
  Rect? _faceRect;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeFaceDetector();
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

      // Update input image format based on platform
      const inputImageFormat = InputImageFormat.yuv420;

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
        final leftEyeOpen = face.leftEyeOpenProbability ?? 0;
        final rightEyeOpen = face.rightEyeOpenProbability ?? 0;

        setState(() {
          _isFaceDetected = true;
          _isBlinking = leftEyeOpen < 0.1 && rightEyeOpen < 0.1;
          _faceRect = face.boundingBox;
        });
      } else {
        setState(() {
          _isFaceDetected = false;
          _isBlinking = false;
          _faceRect = null;
        });
      }
    } catch (e) {
      debugPrint('Error processing image: $e');
      if (mounted && _isFaceDetected) {
        setState(() {
          _isFaceDetected = false;
          _isBlinking = false;
          _faceRect = null;
        });
      }
    }
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

    // Mengubah ukuran preview dari 80% menjadi 60%
    final screenSize = MediaQuery.of(context).size;
    final previewSize = screenSize.width * 0.7; // 60% of screen width

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
                    // Update size for circular border
                    Container(
                      width: previewSize,
                      height: previewSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black26,
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
                    // Update size for face detection overlay
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
                  Text(
                    _isFaceDetected
                        ? 'Wajah Terdeteksi'
                        : 'Wajah Tidak Terdeteksi',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isBlinking
                        ? 'Kedipan Terdeteksi!'
                        : 'Silakan Kedipkan Mata',
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

  // Updated scale calculation method
  double _getCameraScale(double previewSize) {
    if (_cameraController == null) return 1.0;

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final cameraRatio = _cameraController!.value.aspectRatio;

    // Calculate the scale needed to fill the circle
    double scale = 1.0;
    if (cameraRatio > deviceRatio) {
      // If camera is wider, scale to match height
      scale = previewSize / (size.width / cameraRatio);
    } else {
      // If camera is taller, scale to match width
      scale = previewSize / size.width;
    }

    // Add additional scaling factor to ensure circle is filled
    return scale * 1.5; // Adjust this multiplier as needed
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
      ..color = Colors.green;

    // Improve face box scaling and positioning
    final scaleX = size.width;
    final scaleY = size.height;

    final scaledRect = Rect.fromLTWH(
      size.width - (rect.left * scaleX), // Mirror horizontally for front camera
      rect.top * scaleY,
      rect.width * scaleX,
      rect.height * scaleY,
    );

    canvas.drawRect(scaledRect, paint);
  }

  @override
  bool shouldRepaint(FaceBoxPainter oldDelegate) => true;
}
