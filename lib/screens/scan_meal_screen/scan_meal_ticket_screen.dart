import 'dart:io';

import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/consume_meal_validated_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanMealTicketScreen extends StatefulWidget {
  // declaration
  const ScanMealTicketScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanMealTicketScreenState();
}

class _ScanMealTicketScreenState extends State<ScanMealTicketScreen> {
  String _ticketNumber = "";
  String _mode = "SCAN"; // ||"VERIFY" || "SUCCESS" || "ERROR"
  void setMode(String value) {
    setState(() {
      _mode = value;
    });
  } // ||"VERIFY" || "SUCCESS" || "ERROR"

  // QR code
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void setTicketNumber(String value) {
    setState(() {
      _ticketNumber = value;
    });
  }

  void verifyTicket(String ticketNumber) {
    // setMode("VERIFY");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ConsumeMealScreen(
            ticketNumber: ticketNumber,
          );
        },
      ),
    );
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
  Widget build(BuildContext context) {
    // avoid black camera screen error
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Scanner ticket sakafo"),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _scanMealTicketContent(context),
          ],
        ),
      ),
    );
  }

  Widget _scanMealTicketContent(BuildContext context) {
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
        // Manual add
        if (result != null) Text('Result ${result!.code}'),
        Text(
          'Ou saisir',
          style: AppTextStyle.text(color: AppColors.PRIMARY),
        ),
        Text(
          'Ticket n° ${_ticketNumber}',
          style: AppTextStyle.head2(color: AppColors.PRIMARY),
        ),
        TextFormField(
          autofocus: false,
          decoration: const InputDecoration(
            // icon: Icon(CupertinoIcons.ticket),
            // labelText: "Ticket n°",
            hintText: "Ex. 001A",
          ),
          onChanged: (String? value) {
            setTicketNumber(value!);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ButtonSolid(
          "Hisakafo",
          icon: CupertinoIcons.tickets,
          color: AppColors.SECONDARY,
          onPressed: () {
            // Navigator.pushNamed(context, '/consume');
            verifyTicket(_ticketNumber);
          },
        )
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
        var ticketNumber = scanData.code!;
        setTicketNumber(ticketNumber);
        if (ticketNumber != _ticketNumber ||
            ticketNumber != null ||
            ticketNumber != "") {
          verifyTicket(ticketNumber);
          controller.pauseCamera();
          // controller.dispose();
          // super.dispose();
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
