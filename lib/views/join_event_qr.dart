import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sqa/themes/sqa_theme.dart';

class JoinEventQr extends StatefulWidget {
  const JoinEventQr({super.key});

  @override
  State<JoinEventQr> createState() => _JoinEventQrState();
}

class _JoinEventQrState extends State<JoinEventQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid || Platform.isIOS) {
      controller!.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Event QR Code"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: SqaTheme.primaryColor,
              borderRadius: 5,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        String eventId = scanData.code!;
        String routeName = Uri(
          path: '/detail',
          queryParameters: {
            'eventId': eventId,
          },
        ).toString();

        Navigator.of(context).pushNamed(routeName);
      }
    });
  }
}
