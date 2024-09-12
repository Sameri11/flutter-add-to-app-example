import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CameraView(camera: camera),
    );
  }
}

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  CameraView({required this.camera});

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    unawaited(requestCameraPermission());
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Request the permission
      var result = await Permission.camera.request();
      if (result.isGranted) {
        // Permission granted
        print("Camera permission granted.");
      } else {
        // Permission denied
        print("Camera permission denied.");
      }
    } else {
      // Permission is already granted
      print("Camera permission was already granted.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Camera Initialization'),
        ),
        child: Center(child: CupertinoActivityIndicator()),
      );
    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Live Camera Feed'),
      ),
      child: CameraPreview(_controller),
    );
  }
}
