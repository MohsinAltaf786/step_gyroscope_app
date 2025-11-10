import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_proj/models/my_model.dart';

class MyProvider extends ChangeNotifier {
  MyProvider() {
    getData();
  }

  MyModel? myModel;
  bool loading = false;

  Future<void> getData() async {
    loading = true;
    notifyListeners();

    const String url =
        'https://www.propstake.ai/api/dld?page=1&page_size=1&location_country=PK';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        myModel = MyModel.fromJson(data);
        print('Data fetched successfully');
      } else {
        print(' Unexpected response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
