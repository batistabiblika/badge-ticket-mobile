import 'dart:io';

import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrScreen extends StatefulWidget {
  // declaration
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String _qrNumber = "";
  void setQrNumber(String value) {
    setState(() {
      _qrNumber = value;
    });
  }

  bool _flash = AppSettings.FLASH;
  void setFlash(bool value) {
    setState(() {
      _flash = value;
    });
  }

  // QR code
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // shared preference
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void switchFlash() async {
    final SharedPreferences prefs = await _prefs;
    if (controller != null && mounted) {
      var isFlashOn = await controller!.getFlashStatus() ?? false;
      bool flashPref = prefs.getBool('flash') ?? AppSettings.FLASH;
      if (!isFlashOn && flashPref) {
        controller!.toggleFlash();
      }
    }
  }

  Future<void> loadSetting() async {
    // print("Loading setting");
    final SharedPreferences prefs = await _prefs;
    bool flash = prefs.getBool('flash') ?? AppSettings.FLASH;
    setFlash(flash);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    // avoid black camera screen error
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
      switchFlash();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Scanner code"),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          // children: <Widget>[_HomeContent(), _bottomBar()],
          children: <Widget>[
            _scanContent(context),
          ],
        ),
      ),
    );
  }

  Widget _scanContent(BuildContext context) {
    return Container(
        child: ListView(
      padding: EdgeInsets.only(top: 16, bottom: 64, left: 16, right: 16),
      shrinkWrap: true,
      children: <Widget>[
        // QR Code
        Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 360,
          child: _buildQrView(context),
        ),

        Container(
            height: 48,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Flash du scan (appareil photo)",
                  style: AppTextStyle.text(color: AppColors.PRIMARY),
                ),
                Switch(
                    value: _flash,
                    activeColor: AppColors.GREEN,
                    onChanged: (value) async {
                      setFlash(value);
                      if (controller != null && mounted) {
                        controller!.toggleFlash();
                        // var isFlashOn =
                        //     await controller!.getFlashStatus() ?? false;
                        // if (!isFlashOn ) {
                        //   controller!.toggleFlash();
                        // }
                      }

                      SharedPreferences prefs = await _prefs;
                      await prefs.setBool('flash', value);
                    })
              ],
            )),

        SizedBox(
          height: 8,
        ),
        Text(
          'Scan n° ${_qrNumber}',
          style: AppTextStyle.head2(color: AppColors.PRIMARY),
        ),
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 240.0
        : 360.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    // controller.getFlashStatus();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (scanData.code != null) {
        var qrNumber = scanData.code!;
        setQrNumber(qrNumber);
        if (qrNumber != _qrNumber || qrNumber != null || qrNumber != "") {
          // verifyTicket(qrNumber);
          // Send data back
          Navigator.pop(context, qrNumber);
          controller.pauseCamera();
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
