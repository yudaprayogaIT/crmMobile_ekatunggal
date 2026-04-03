// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';

// class FcRegisterScreen extends StatefulWidget {
//   @override
//   _FaceVerificationPageState createState() => _FaceVerificationPageState();
// }

// class _FaceVerificationPageState extends State<FcRegisterScreen> {
//   CameraController? _cameraController;
//   List<CameraDescription>? cameras;
//   bool _isCameraInitialized = false;
//   String? _imagePath;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null && cameras!.isNotEmpty) {
//       _cameraController = CameraController(cameras![1], ResolutionPreset.high);
//       await _cameraController!.initialize();
//       setState(() {
//         _isCameraInitialized = true;
//       });
//     }
//   }

//   Future<void> _captureImage() async {
//     if (_cameraController != null && _cameraController!.value.isInitialized) {
//       try {
//         final XFile file = await _cameraController!.takePicture();
//         final imagePath = file.path;
//         setState(() {
//           _imagePath = imagePath;
//         });
//         _showResultDialog();
//       } catch (e) {
//         print('Error capturing image: $e');
//       }
//     }
//   }

//   void _showResultDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Verification Result'),
//         content: _imagePath != null
//             ? Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Face verified successfully!'),
//                   SizedBox(height: 10),
//                   Image.file(File(_imagePath!)),
//                 ],
//               )
//             : Text('Failed to capture image'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Face Verification')),
//       body: Stack(
//         children: [
//           if (_isCameraInitialized) CameraPreview(_cameraController!),
//           if (!_isCameraInitialized) Center(child: CircularProgressIndicator()),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0), // Jarak dari bawah
//               child: ElevatedButton(
//                 onPressed: _captureImage,
//                 child: Text('Capture Face'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
