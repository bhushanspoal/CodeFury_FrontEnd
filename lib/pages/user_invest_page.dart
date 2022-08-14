import 'package:codefury_start_up_app/pages/payment_gateway.dart';
import 'package:flutter/material.dart';

import '../models/company_api_model.dart';
import '../services/company_api_services.dart';

class User_invest_page extends StatefulWidget {
  const User_invest_page({Key? key}) : super(key: key);

  @override
  State<User_invest_page> createState() => _User_invest_pageState();
}

class _User_invest_pageState extends State<User_invest_page> {
  List<CompanyApi>?companyapi;
  var isLoaded=false;
  @override
  void initState() {
    super.initState();

    getData();
  }
  getData() async{
    companyapi = await RemoteService().getCompanyApi();
    if (companyapi != null)
    {
      setState(() {
        isLoaded=true;
      });
    }
  }
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invest in what you love'),),
      body : Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: companyapi?.length,
            itemBuilder: (context,index){
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5,),
                  child: Column(
                    children: [
                      Text("Company Name : ${companyapi![index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                      GestureDetector(onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Payment_gateway()));
                      },
                        child: const Text("Invest",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 25,)
                    ],
                  ),
                ),
              );
            }),
        replacement: const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
