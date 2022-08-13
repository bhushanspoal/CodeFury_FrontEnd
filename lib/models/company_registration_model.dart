class CompanyModel {
  String? cid;
  String? email;
  String? companyName;
  String? ownerName;

  CompanyModel({this.cid, this.email, this.companyName, this.ownerName});

  // receiving data from server
  factory CompanyModel.fromMap(map) {
    return CompanyModel(
      cid: map['cid'],
      email: map['email'],
      companyName: map['companyName'],
      ownerName: map['ownerName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'email': email,
      'companyName': companyName,
      'ownerName': ownerName,
    };
  }
}