// To parse this JSON data, do
//
//     final companyInvestors = companyInvestorsFromJson(jsonString);

import 'dart:convert';

List<CompanyInvestors> companyInvestorsFromJson(String str) => List<CompanyInvestors>.from(json.decode(str).map((x) => CompanyInvestors.fromJson(x)));

String companyInvestorsToJson(List<CompanyInvestors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyInvestors {
  CompanyInvestors({
    required this.id,
    required this.investorName,
    required this.noInvested,
    required this.mailId,
    required this.linkedinProfile,
  });

  int id;
  String investorName;
  String noInvested;
  String mailId;
  String linkedinProfile;

  factory CompanyInvestors.fromJson(Map<String, dynamic> json) => CompanyInvestors(
    id: json["id"],
    investorName: json["investor_name"],
    noInvested: json["no_invested"],
    mailId: json["mailId"],
    linkedinProfile: json["linkedin_profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "investor_name": investorName,
    "no_invested": noInvested,
    "mailId": mailId,
    "linkedin_profile": linkedinProfile,
  };
}
