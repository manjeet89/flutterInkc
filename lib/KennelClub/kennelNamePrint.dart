import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkc/KennelClub/kennelnamehistory.dart';
import 'package:inkc/bottom_nav_pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Kennel {
  final String kennelId;
  final String kennelName;

  Kennel({required this.kennelId, required this.kennelName});
}

class KennelNameShow extends StatefulWidget {
  const KennelNameShow({super.key});

  @override
  State<KennelNameShow> createState() => _KennelNameShowState();
}

class _KennelNameShowState extends State<KennelNameShow> {
  List<Map<String, dynamic>> kennels = [];
  Map<String, dynamic>? selectedKennel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };
    final response = await http.get(
        Uri.parse('https://new-demo.inkcdogs.org/api/user/kennel_details'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract kennel info
      final Map<String, dynamic> kennelInfo = jsonData['data']['kennel_info'];

      // Extract kennel second owner info
      final List<dynamic> kennelSecondOwnerList =
          jsonData['data']['kennel_second_owner'];

      setState(() {
        kennels = [kennelInfo, ...kennelSecondOwnerList];
        selectedKennel = kennels.isNotEmpty ? kennels[0] : null;
      });
    } else {
      // Handle error
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Map<String, dynamic>>(
              value: selectedKennel,
              onChanged: (Map<String, dynamic>? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedKennel = newValue;
                  });
                }
              },
              items: kennels.map<DropdownMenuItem<Map<String, dynamic>>>(
                  (Map<String, dynamic> kennel) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: kennel,
                  child: Text(kennel['kennel_name']),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            selectedKennel != null
                ? Text('Selected kennel: ${selectedKennel!['kennel_name']}')
                : Text('No kennels available'),
          ],
        ),
      ),
    );
  }
}
