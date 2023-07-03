import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../Missing/Missing_Persons.dart';

class Controller extends GetxController {
  RxString message = ''.obs;
  RxBool passwordIsValid = false.obs;
  RxList<dynamic> items = <dynamic>[].obs;
  RxBool isLoading = true.obs;
  RxString userId = ''.obs;

  Future<void> registerData(String name, String email, String password) async {
    const url = 'https://missing-person.online/public/api/auth/register';

    final response = await http.post(Uri.parse(url), body: {
      'name': name,
      'email': email,
      'password': password,
    });

    final responseBody = jsonDecode(response.body);

    message.value = responseBody['email']
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    await prefs.remove('token');

    const url = 'https://missing-person.online/public/api/auth/logout';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode != 200) {
      print('Error logging out');
    }

    Get.offAllNamed('/login');
  }

  Future<void> loginData(email, password) async {
    const url = 'https://missing-person.online/public/api/auth/login';

    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final loginToken = responseBody['access_token'].toString();
      passwordIsValid.value = true;

      if (loginToken.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginToken);

        Get.offAllNamed('/home');
        passwordIsValid.value = true;
      } else {
        passwordIsValid.value = false;
      }
    } else {
      passwordIsValid.value = false;
    }
  }

  Future<dynamic> addMissingData(
    String childName,
    String country,
    String age,
    String city,
    String parentName,
    String phone,
    String id,
    File imageFile,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? addToken = prefs.getString('token');

    if (addToken != null) {
      const url = 'https://missing-person.online/public/api/store';

      final request = http.MultipartRequest('POST', Uri.parse(url));
      final image = http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.jpg',
      );

      request.fields.addAll({
        'name': childName,
        'governorate': country,
        'age': age,
        'city': city,
        'fatherName': parentName,
        'phone': phone,
        'nationalNumber': id,
        'token': addToken,
      });

      request.files.add(image);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseBody2 = jsonDecode(responseBody);

      print('Response: $responseBody2');
      return responseBody2;
    } else {
      throw Exception('Token is null');
    }
  }

  Future<void> getMyPosts() async {
    final prefs = await SharedPreferences.getInstance();
    String? getMyPostsToken = prefs.getString('token');

    if (getMyPostsToken != null) {
      const url = 'https://missing-person.online/public/api/missing';

      try {
        final response = await http.get(Uri.parse(url));

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['data'] is List) {
            List<dynamic> filteredList = responseBody['data']
                .where((item) => item['user_id'] == userId)
                .toList();

            isLoading.value = false;
            List<dynamic> reversedList = filteredList.reversed.toList();
            items.value = reversedList;
          }

          print(responseBody);
          // print('Response: ${responseBody['user_id']}');
        } else {
          isLoading.value = true; // Set the loading state to true
          throw Exception('Check your internet connection!');
        }
      } catch (e) {
        isLoading.value = true; // Set the loading state to true
        throw Exception('Failed to retrieve posts: $e');
      }
    } else {
      throw Exception('Token is null');
    }
  }

  Future<void> getAllData() async {
    final prefs = await SharedPreferences.getInstance();
    String? getToken = prefs.getString('token');

    if (getToken != null) {
      const url = 'https://missing-person.online/public/api/missing';

      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $getToken',
      });

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['data'] is List) {
          isLoading.value = false;
          List<dynamic> reversedList = responseBody['data'].reversed.toList();
          items.value = reversedList;
        }

        print(responseBody);
      } else {
        isLoading.value = true; // Set the loading state to true
        throw Exception('Check your internet connection!');
      }
    } else {
      throw Exception('Token is null');
    }
  }

  Future sendEmail({
    // ignore: non_constant_identifier_names
    required First_name,
    // ignore: non_constant_identifier_names
    required Last_name,
    // ignore: non_constant_identifier_names
    required Email,
    // ignore: non_constant_identifier_names
    required City,
    // ignore: non_constant_identifier_names
    required Governorate,
    // ignore: non_constant_identifier_names
    required Problem,
  }) async {
    const serviceId = 'service_cbuwqto';
    const templateId = 'template_qldtq95';
    const userId = 'Qqn8y5ulzlwAIAVtB';
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          'user_firstName': First_name,
          'user_lastName': Last_name,
          'user_email': Email,
          'user_city': City,
          'user_governorate': Governorate,
          'user_message': Problem,
        }
      }),
    );
    print(response.body);
  }

  void deleteMissing(item) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url =
          'https://missing-person.online/public/api/missing/${item['id']}';

      try {
        final response = await http.delete(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        });

        if (response.statusCode == 200) {
          print('Item deleted!');
          getAllData();
        } else {
          throw Exception('Error deleting item');
        }
      } catch (error) {
        print('Error deleting item: $error');
        // Perform any necessary error handling
      }
    } else {
      throw Exception('Token is null');
    }
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void updateData(String token, FormData addMissingData) async {
    try {
      final response = await http.post(
        Uri.parse('https://missing-person.online/public/api/update'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: addMissingData,
      );
      if (response.statusCode == 200) {
        // Handle successful response
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        // Redirect to the person page
        navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => const missingChildrenScreen(),
          ),
        );
      } else {
        // Handle error response
        final responseError = jsonDecode(response.body);
        print(responseError['message']);
      }
    } catch (e) {
      // Handle network or other exceptions
      print(e.toString());
    }
  }
}
