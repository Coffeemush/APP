import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:coffeemush/controllers/scanning_controller.dart';
import 'package:coffeemush/widgets/drawer.dart';

class QRScanningScreen extends StatefulWidget {
  @override
  _QRScanningScreenState createState() => _QRScanningScreenState();
}

class _QRScanningScreenState extends State<QRScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final ScanningController scanningController = Get.put(ScanningController());

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      drawer: CMDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/logo.png', height: 100),
                SizedBox(height: 20),
                Text(
                  'Scan the QR of your CoffeeMush',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      scanningController.connect(scanData.code ?? '');
    });
  }
}