// To parse this JSON data, do
//
//     final companyApi = companyApiFromJson(jsonString);

import 'dart:convert';

List<CompanyApi> companyApiFromJson(String str) => List<CompanyApi>.from(json.decode(str).map((x) => CompanyApi.fromJson(x)));

String companyApiToJson(List<CompanyApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyApi {
  CompanyApi({
    required this.id,
    required this.name,
    required this.info,
    required this.location,
    required this.mailId,
    required this.ownerName,
    required this.amount,
  });

  int id;
  String name;
  String info;
  String location;
  String mailId;
  String ownerName;
  String amount;

  factory CompanyApi.fromJson(Map<String, dynamic> json) => CompanyApi(
    id: json["id"],
    name: json["name"],
    info: json["info"],
    location: json["location"],
    mailId: json["mailId"],
    ownerName: json["ownerName"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "info": info,
    "location": location,
    "mailId": mailId,
    "ownerName": ownerName,
    "amount": amount,
  };
}
