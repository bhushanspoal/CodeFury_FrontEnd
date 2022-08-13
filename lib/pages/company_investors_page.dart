import 'package:codefury_start_up_app/models/company_investors_model.dart';
import 'package:flutter/material.dart';

import '../services/company_investors.dart';

class Company_investors_page extends StatefulWidget {
  const Company_investors_page({Key? key}) : super(key: key);

  @override
  State<Company_investors_page> createState() => _Company_investors_pageState();
}

class _Company_investors_pageState extends State<Company_investors_page> {

  List<CompanyInvestors>?companyapi;
  var isLoaded=false;

  void initState() {
    super.initState();

    getData();
  }

  getData() async{
     companyapi = await RemoteService().getCompanyInvestors();
    if (companyapi != null)
    {
      setState(() {
        isLoaded=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: companyapi?.length,
            itemBuilder: (context,index){
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5,),
                  child: Column(
                    children: [
                      Text("The investors name : ${companyapi![index].investorName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                      Text("The no of companies invested in are : ${companyapi![index].noInvested}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      Text("Contact Deatils, Owner' mailid ${companyapi![index].mailId} and "
                          "LinkedIN : ${companyapi![index].linkedinProfile}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
