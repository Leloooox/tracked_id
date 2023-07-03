import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../API/Controller.dart';

class update_data extends StatefulWidget {
  Map<String, dynamic> user;
  update_data({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _update_dataState createState() => _update_dataState();
}

class _update_dataState extends State<update_data> {
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Controller controller = Get.put(Controller());

  dynamic x;
  dynamic y;
  dynamic data;
  @override
  void initState() {
    childNameController.text = widget.user['name'];
    cityController.text = widget.user['city'];
    countryController.text = widget.user['governorate'];
    ageController.text = widget.user['age'].toString();
    parentNameController.text = widget.user['fatherName'];
    phoneController.text = widget.user['phone'].toString();
    idController.text = widget.user['nationalNumber'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 25,
                bottom: 15,
                start: 15,
                end: 15,
              ),
              child: Column(
                children: [
                  const Text(
                    "تعديل بيانات الشخص",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "بيانات الطفل",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: childNameController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'الأسم بالكامل',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' هذا الحقل مطلوب';
                      } else if (value.length < 3) {
                        return 'يجب ان يحتوي الاسم علي 3 احرف علي الاقل';
                        // ignore: unrelated_type_equality_checks
                      } else if (value.length > 40) {
                        return 'يجب ان يحتوي الاسم علي 40 حرف علي الاكثر';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cityController,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: ' المحافظة',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' هذا الحقل مطلوب';
                            } else if (value.length < 3) {
                              return 'يجب ان تحتوي المحافظة علي 3 احرف علي الاقل';
                              // ignore: unrelated_type_equality_checks
                            } else if (value.length > 40) {
                              return 'يجب ان تحتوي المحافظة علي 40 حرف علي الاكثر';
                              // ignore: unrelated_type_equality_checks
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: countryController,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'المدينة',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' هذا الحقل مطلوب';
                            } else if (value.length < 3) {
                              return 'يجب ان تحتوي المدينة علي 3 احرف علي الاقل';
                              // ignore: unrelated_type_equality_checks
                            } else if (value.length > 40) {
                              return 'يجب ان تحتوي المدينة علي 40 حرف علي الاكثر';
                              // ignore: unrelated_type_equality_checks
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ageController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'العمر',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' هذا الحقل مطلوب';
                        // ignore: unnecessary_null_comparison
                      } else if (value.length == null) {
                        return 'يجب ان يحتوي العمر علي رقم واحد علي الاقل';
                        // ignore: unrelated_type_equality_checks
                      } else {
                        if (value.length > 2) {
                          return 'يجب ان يحتوي العمر علي رقمين علي الاكثر';
                          // ignore: unrelated_type_equality_checks
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "صورة الطفل",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: () async {
                        x = ImagePicker();
                        y = await x.getImage(
                          source: ImageSource.gallery,
                        );

                        //7tit el setstate 34an el image tban t7t 34an mknt4 3uza tban
                        setState(() {
                          if (y != null) {
                            data = File(y.path);
                          }
                        });
                      },
                      child: const Text(
                        "Press to choose image",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    child: (data == null)
                        ? const Text(
                            "No Image yet",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        : Image.file(data),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "بيانات ولي الأمر",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: parentNameController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'الأسم بالكامل',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' هذا الحقل مطلوب';
                      } else if (value.length < 3) {
                        return 'يجب ان يحتوي الاسم علي 3 احرف علي الاقل';
                        // ignore: unrelated_type_equality_checks
                      } else if (value.length > 40) {
                        return 'يجب ان تحتوي المحافظة الاسم علي 40 حرف علي الاكثر';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'رقم الهاتف',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' هذا الحقل مطلوب';
                      } else if (value.length < 11) {
                        return 'يجب ان يحتوي الهاتف علي 11 رقم علي الاقل';
                        // ignore: unrelated_type_equality_checks
                      } else if (value.length > 11) {
                        return 'يجب ان يحتوي الهاتف علي 11 رقم علي الاكثر';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: idController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'الرقم القومي',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' هذا الحقل مطلوب';
                      } else if (value.length < 14) {
                        return 'يجب ان يحتوي الرقم القومي علي 14 رقم علي الاقل';
                        // ignore: unrelated_type_equality_checks
                      } else if (value.length > 14) {
                        return 'يجب ان يحتوي الرقم القومي علي 14 رقم علي الاكثر';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    highlightColor: const Color(0xff112031),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    height: 60,
                    minWidth: double.infinity,
                    color: const Color(0xff24baef),
                    onPressed: () {
                      controller.updateUser(id: widget.user['id']);
                    },
                    child: const Text(
                      'حفظ التعديلات',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "جميع الحقوق محفوظة © 2023 Track ID",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
