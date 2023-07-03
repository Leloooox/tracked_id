import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tracked_id/API/Controller.dart';

import '../Missing/Add_missing_person.dart';
import '../Missing/Missing_Persons.dart';

// ignore: camel_case_types
class Search_Person_Page extends StatefulWidget {
  const Search_Person_Page({Key? key}) : super(key: key);

  @override
  State<Search_Person_Page> createState() => _Search_Person_PageState();
}

// ignore: camel_case_types
class _Search_Person_PageState extends State<Search_Person_Page> {
  final Controller controller = Get.put(Controller());

  String? result;
  final picker = ImagePicker();
  File? img;
  var url = "https://b70c-197-53-248-20.eu.ngrok.io/recognize_faces";
  Future pickImage() async {
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      img = File(pickedFile!.path);
    });
  }

  Future<void> upload() async {
    if (img == null) {
      // Display an error message if no image is selected
      setState(() {
        result = "Please select an image first";
      });
      return;
    }

    final request = http.MultipartRequest("POST", Uri.parse(url));
    final header = {"Content_type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'image', img!.readAsBytes().asStream(), img!.lengthSync(),
        filename: img!.path.split('/').last));
    request.headers.addAll(header);

    try {
      final response = await request.send();
      final resJson = await response.stream.bytesToString();
      print(resJson);
      if (response.statusCode == 200) {
        // Parse the JSON response and update the result variable
        setState(() {
          result = jsonDecode(resJson)['id'];
        });
      } else {
        // Display an error message if the response status code is not 200
        setState(() {
          result = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      // Display an error message if an exception is thrown
      setState(() {
        result = "Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      body: SafeArea(
        child: Center(
          child: img == null
              ? Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 15,
                          end: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.all(
                                15,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "ابحث عن شخص مفقود",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "التحقق اذا كان الشخص مفقود ام لا",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: img == null
                                        ? Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: MaterialButton(
                                              minWidth: double.infinity,
                                              height: 40,
                                              onPressed: () async {
                                                pickImage();
                                              },
                                              child: const Text(
                                                "Press to take image",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: (img == null)
                                                ? const Text(
                                                    "No Image yet",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  )
                                                : Image.file(img!),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: img == null
                                        ? Column(
                                            children: [
                                              const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "التعليمات للحصول علي جودة عالية :",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.lightbulb,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "اضائة جيدة للصوره",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.person_sharp,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "شخص واحد فقط في الصوره",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.visibility,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "النظر مباشره للكاميرا",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Text(
                                            ' $result',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    highlightColor: const Color(0xff112031),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    height: 40,
                                    onPressed: () async {
                                      await upload();
                                    },
                                    color: const Color(0xff24baef),
                                    minWidth: double.infinity,
                                    child: const Text(
                                      'ابحث',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "جميع الحقوق محفوظة © 2023 Track ID",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 15,
                          end: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.all(
                                15,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "ابحث عن شخص مفقود",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "التحقق اذا كان الشخص مفقود ام لا",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: img == null
                                        ? Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: MaterialButton(
                                              minWidth: double.infinity,
                                              height: 40,
                                              onPressed: () async {
                                                pickImage();
                                              },
                                              child: const Text(
                                                "Press to take image",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: (img == null)
                                                ? const Text(
                                                    "No Image yet",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  )
                                                : Image.file(img!),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: img == null
                                        ? Column(
                                            children: [
                                              const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "التعليمات للحصول علي جودة عالية :",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.lightbulb,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "اضائة جيدة للصوره",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.person_sharp,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "شخص واحد فقط في الصوره",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: const [
                                                  Icon(
                                                    Icons.visibility,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "النظر مباشره للكاميرا",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Text(
                                            ' $result',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    highlightColor: const Color(0xff112031),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    height: 40,
                                    onPressed: () async {
                                      await upload();
                                    },
                                    color: const Color(0xff24baef),
                                    minWidth: double.infinity,
                                    child: const Text(
                                      'ابحث',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(
                          bottom: 5,
                        ),
                        child: Text(
                          "جميع الحقوق محفوظة © 2023 Track ID",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
              icon: Icon(
                Icons.filter_center_focus_rounded,
              ),
              label: 'بحث عن مفقود',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_card_rounded,
              ),
              label: 'بلغ عن مفقود',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: ' المفقودون',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: const Color(0xff24baef),
          backgroundColor: const Color(0xff112031),
          unselectedItemColor: Colors.white,
          onTap: (f) async {
            if (f == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Search_Person_Page(),
                ),
              );
            } else if (f == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMissingPerson(),
                ),
              );
            } else if (f == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const missingChildrenScreen(),
                ),
              );
            }
          }),
    );
  }
}
