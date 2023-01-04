import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

String? stringResponse;
Map mapResponse = {};
Map dataResponse = {};
List listResponse = [];

class FetchApi extends StatefulWidget {
  const FetchApi({Key? key}) : super(key: key);

  @override
  State<FetchApi> createState() => _FetchApiState();
}

class _FetchApiState extends State<FetchApi> {
  Future apicall() async {
    Response response = await get(Uri.parse(
        // 'https://reqres.in/api/users/2'
        'https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      // stringResponse = response.body;
      setState(() {});
      mapResponse = jsonDecode(response.body);
      // dataResponse = mapResponse['data'];

      listResponse = mapResponse['data'];
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.amber,
          title: const Text('Api Integration'),
        ),
        backgroundColor: Colors.grey,
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: listResponse.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.network(listResponse[index]['avatar']),
                    ),
                    Text(
                      'Id : ${listResponse[index]['id'].toString()}',
                      style: const TextStyle(color: Colors.amber),
                    ),
                    Text(
                      'Email : ${listResponse[index]['email'].toString()}',
                      style: const TextStyle(color: Colors.amber),
                    ),
                    Text(
                      'First Name : ${listResponse[index]['first_name'].toString()}',
                      style: const TextStyle(color: Colors.amber),
                    ),
                    Text(
                      'Last Name : ${listResponse[index]['last_name'].toString()}',
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
