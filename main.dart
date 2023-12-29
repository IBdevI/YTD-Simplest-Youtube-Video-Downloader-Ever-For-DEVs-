import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() => runApp(YTDapp());

class YTDapp extends StatefulWidget {
  @override
  State<YTDapp> createState() => _YTDappState();
}

class _YTDappState extends State<YTDapp> {
  final TextEditingController linkController = TextEditingController();
  //Enviar

  late final link = linkController.text;

  Future<String> sendLink(String link) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5000/videos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'link': link,
        }),
      );

      if (response.statusCode == 200) {
        print('Name sent successfully!');
        
        return 'Transaction added successfully'; 
      } else {
        throw Exception('Failed to send transaction: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error sending transaction: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        title: 'YTD',
        home: Scaffold(
          appBar: AppBar(
              title: Text(
                'YTD',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.yellowAccent),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: TextField(
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(labelText: ' Paste Link Here'),
                  controller: linkController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: IconButton(
                        onPressed: () {
                          sendLink(linkController.text);
                          linkController.clear();
                        },
                        icon: Icon(Icons.download)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
