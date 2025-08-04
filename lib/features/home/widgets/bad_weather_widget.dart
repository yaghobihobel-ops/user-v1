import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/location/controllers/location_controller.dart';
import 'package:stackfood_multivendor/helper/address_helper.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';

class BadWeatherWidget extends StatefulWidget {
  const BadWeatherWidget({super.key});

  @override
  State<BadWeatherWidget> createState() => _BadWeatherWidgetState();
}

class _BadWeatherWidgetState extends State<BadWeatherWidget> {
  final LocationController _locationController = Get.find<LocationController>();
  late Future<BadWeatherAlertData?> _alertDataFuture;

  @override
  void initState() {
    super.initState();
    _alertDataFuture = _fetchAlertData();
  }

  Future<BadWeatherAlertData?> _fetchAlertData() async {
    final address = AddressHelper.getAddressFromSharedPref();
    if (address == null) return null;

    await _locationController.getZone(address.latitude, address.longitude, false);

    final zoneData = address.zoneData?.firstWhereOrNull(
      (data) => data.id == address.zoneId &&
      data.increasedDeliveryFeeStatus == 1 &&
      data.increaseDeliveryFeeMessage?.isNotEmpty == true,
    );

    return zoneData != null ? BadWeatherAlertData(
      showAlert: zoneData.increasedDeliveryFeeStatus == 1,
      message: zoneData.increaseDeliveryFeeMessage ?? '',
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BadWeatherAlertData?>(
      future: _alertDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        }

        final alertData = snapshot.data;
        if (alertData == null || !alertData.showAlert || alertData.message.isEmpty) {
          return const SizedBox();
        }

        return _buildAlertWidget(context, alertData.message);
      },
    );
  }

  Widget _buildAlertWidget(BuildContext context, String message) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeSmall,
      ),
      child: Row(children: [

        Image.asset(Images.weather, height: 50, width: 50),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        Expanded(
          child: Text(
            message,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white),
          ),
        ),

      ]),
    );
  }
}

class BadWeatherAlertData {
  final bool showAlert;
  final String message;

  BadWeatherAlertData({required this.showAlert, required this.message});
}