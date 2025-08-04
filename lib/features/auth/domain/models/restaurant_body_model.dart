import 'dart:convert';

class RestaurantBodyModel {
  String? translation;
  String? deliveryTimeType;
  String? minDeliveryTime;
  String? maxDeliveryTime;
  String? lat;
  String? lng;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? zoneId;
  List<String>? cuisineId;
  String? businessPlan;
  String? packageId;
  String? tin;
  String? tinExpireDate;

  RestaurantBodyModel({
    this.translation,
    this.deliveryTimeType,
    this.minDeliveryTime,
    this.maxDeliveryTime,
    this.lat,
    this.lng,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.password,
    this.zoneId,
    this.cuisineId,
    this.businessPlan,
    this.packageId,
    this.tin,
    this.tinExpireDate,
  });

  RestaurantBodyModel.fromJson(Map<String, dynamic> json) {
    translation = json['translations'];
    deliveryTimeType = json['delivery_time_type'];
    minDeliveryTime = json['min_delivery_time'];
    maxDeliveryTime = json['max_delivery_time'];
    lat = json['lat'];
    lng = json['lng'];
    fName = json['fName'];
    lName = json['lName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    zoneId = json['zone_id'];
    cuisineId = json['cuisine_ids'];
    businessPlan = json['business_plan'];
    packageId = json['package_id'];
    tin = json['tin'];
    tinExpireDate = json['tin_expire_date'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['translations'] = translation!;
    data['delivery_time_type'] = deliveryTimeType!;
    data['min_delivery_time'] = minDeliveryTime!;
    data['max_delivery_time'] = maxDeliveryTime!;
    data['lat'] = lat!;
    data['lng'] = lng!;
    data['fName'] = fName!;
    data['lName'] = lName!;
    data['phone'] = phone!;
    data['email'] = email!;
    data['password'] = password!;
    data['zone_id'] = zoneId!;
    data['cuisine_ids'] = jsonEncode(cuisineId);
    data['business_plan'] = businessPlan ?? '';
    data['package_id'] = packageId!;
    data['tin'] = tin ?? '';
    data['tin_expire_date'] = tinExpireDate ?? '';
    return data;
  }
}
