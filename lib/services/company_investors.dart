import'package:http/http.dart'as http;

import '../models/company_investors_model.dart';


class RemoteService {
  Future<List<CompanyInvestors>?> getCompanyInvestors() async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://codefury.pythonanywhere.com/Investors/?format=json');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return companyInvestorsFromJson(json);
    }
  }
}