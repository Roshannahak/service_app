import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:service_app/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../model/vehicleListData.dart';

class VehicleListPage extends StatefulWidget {
  const VehicleListPage({Key? key}) : super(key: key);

  @override
  State<VehicleListPage> createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  @override
  void initState() {
    _getVehicleList();
    super.initState();
  }

  List<Vehicle> vehicleList = [];
  List vehicleNumberList = [];

  Future _getVehicleList() async {
    const apiUrl = "http://192.168.1.12:3000/api/vehicles";
    final response = await http.get(
      Uri.parse(apiUrl),
    );
    var result = response.body.toString();
    // var result = jsonDecode(response.body);
    // var data = result["vehicles"];
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _vehicle = vehicleListDataFromJson(result);
      print(_vehicle);
      // var _vehicleNo = vehicleListDataFromJson(result);
      setState(() {
        vehicleList = _vehicle.vehicles!;
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No Vehicles Found"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appUiLightColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: appUiThemeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "VA",
                        style: mainHeadingStyle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: appUiLightColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vehicles",
                    style: blackHeadingStyle,
                  ),
                  Image(
                    width: 40,
                    height: 40,
                    image: AssetImage("assets/images/img3.png"),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Divider(
              color: appUiGreyColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: vehicleList.length,
                    itemBuilder: (context, index) {
                      Vehicle data = vehicleList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${data.vehicleNo}",
                              style: textfieldInputStyle,
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  // Widget buildVehicleNumber(VehicleListData e) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       children: e.vehicles!.map((veh) => buildVehicle(veh)).toList(),
  //     ),
  //   );
  // }
  //
  // Widget buildVehicle(Map veh) {
  //   List vNo = [];
  //   try {
  //     vNo = List<Map>.from(veh["vehicles"]);
  //   } catch (e) {}
  //   return Text(
  //     veh["vehicleNo"],
  //     style: TextStyle(
  //         fontWeight: FontWeight.w500, color: appUiTextGreyColor, fontSize: 16),
  //   );
  // }
}
