import 'package:codefury_start_up_app/models/company_api_model.dart';
import'package:http/http.dart'as http;



class RemoteService {
  Future<List<CompanyApi>?> getCompanyApi() async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://codefury.pythonanywhere.com/Companies/?format=json');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return companyApiFromJson(json);
    }
  }
}