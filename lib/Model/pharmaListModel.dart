import 'dart:ffi';

import 'package:flutter/material.dart';

class pharmaModel {
  pharmaList pharmas;

  pharmaModel(
      {this.pharmas,
      });

  factory pharmaModel.fromJson(Map<String, dynamic> json) {
    return pharmaModel(
      pharmas: pharmaList.fromJson(json["Pharmacists"]),

    );
  }
}
class pharmaList {
  List<pharmasAllList> listpharma;
  pharmaList({@required this.listpharma});

  factory pharmaList.fromJson(List<dynamic> json) {
    return pharmaList(

        listpharma: json.map((i) => pharmasAllList.fromJson(i)).toList());
  }
}

class pharmasAllList {


  String id;
  String Email,PharmacyName,PharmacistName,Address,Longitude,Latidute,LicenseNumber,Status,CityId,City,
CreateDate,Subscribtion,WorkingHours,SyndicateNumber,PharmacyPhoto,SyndicateIdPhoto,Mobile,Phone;

  pharmasAllList(
      {@required this.id,
        @required this.Email,this.PharmacyName,this.PharmacistName,this.Address,this.Longitude,this.Latidute,
        this.LicenseNumber,this.Status,this.CityId,this.City,this.CreateDate,this.Subscribtion,this.WorkingHours,
        this.SyndicateNumber,this.PharmacyPhoto,this.SyndicateIdPhoto,this.Mobile,this.Phone
      });


  factory pharmasAllList.fromJson(Map<String, dynamic> json) {
    return pharmasAllList(
      id: json['Id'].toString(),
      Email: json['Email'],
      PharmacyName: json['PharmacyName'],
      PharmacistName: json['PharmacistName'].toString(),
      Address: json['Address'].toString(),
      Longitude: json['Longitude'].toString(),
      Latidute: json['Latidute'].toString(),
      LicenseNumber: json['LicenseNumber'].toString(),
      Status: json['Status'].toString(),
      CityId: json['CityId'].toString(),
      City: json['City'],
      CreateDate: json['CreateDate'],
      Subscribtion: json['Subscribtion'].toString(),
      WorkingHours: json['WorkingHours'],
      SyndicateNumber: json['SyndicateNumber'].toString(),
      PharmacyPhoto: json['PharmacyPhoto'],
      SyndicateIdPhoto: json['SyndicateIdPhoto'],
      Phone: json['Phone'].toString(),
      Mobile: json['Mobile'].toString(),



    );
  }
}