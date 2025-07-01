import 'dart:developer';

import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/qr_scan_pages/complete_setup_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../global/widget/global_widgets/global_widgets.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<StatefulWidget> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.transparent,
      body: Column(
        children: [
          Expanded(child: _buildQrView(context)),
          TextButton(
              onPressed: () {
                GlobalWidgets.deviceCodeBottomSheet();
              },
              child: Text(
                "enter_device_code_manually".L(),
                style: R.textStyles
                    .poppins(color: Colors.white, fontSize: 15.sp)
                    .copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 2),
              ))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Get.context!
              .read<BasePagesSectionProvider>()
              .themeModel
              .themeColor,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 6,
          cutOutSize: 70.w),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          Get.offAndToNamed(CompleteSetupDevice.route,
              arguments: {"isEditAble": false});
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
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
