import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Config with ChangeNotifier {
  List<DeliveryCharge> _deliveryCharge = [];
  int _maxDistance = 0;
  List<String> _slider = [];
  int _stockThreshold = 0;
  GeoPoint _storeLocation;

  List<DeliveryCharge> get deliveryCharge => this._deliveryCharge;

  set deliveryCharge(List<DeliveryCharge> value) =>
      this._deliveryCharge = value;

  get maxDistance => this._maxDistance;

  set maxDistance(value) => this._maxDistance = value;

  List<String> get slider => this._slider;

  set slider(value) => this._slider = value;

  get stockThreshold => this._stockThreshold;

  set stockThreshold(value) => this._stockThreshold = value;

  get storeLocation => this._storeLocation;

  set storeLocation(value) => this._storeLocation = value;

  fetchAllConfig() async {
    var firestore = FirebaseFirestore.instance;
    var doc =
        await firestore.collection('config').doc('vhNtdF4QqHu5ndRVTPYG').get();
    var data = doc.data();
    _maxDistance = data['max_distance'];
    _stockThreshold = data['stock_threshold'];
    _storeLocation = data['store_location'];
    var sliderTemp = data['slider'];
    _slider = List<String>.from(sliderTemp);

    var deliveryData = data['delivery_charge'];
    _deliveryCharge = List<DeliveryCharge>.from(deliveryData.map((e) {
      var charge = e['charge'];
      var km = e['km'];
      return DeliveryCharge(charge: charge, km: km);
    }).toList());
  }
}

class DeliveryCharge {
  final int charge;
  final int km;

  DeliveryCharge({@required this.charge, @required this.km});
}
