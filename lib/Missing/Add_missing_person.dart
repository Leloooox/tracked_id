import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../API/Controller.dart';
import '../Search/Search_Page.dart';
import 'Missing_Persons.dart';

class AddMissingPerson extends StatefulWidget {
  const AddMissingPerson({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddMissingPersonState createState() => _AddMissingPersonState();
}

class _AddMissingPersonState extends State<AddMissingPerson> {
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
  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      body: Form(
        key: formKey,
        child: SafeArea(
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
                      "بلغ عن شخص مفقود",
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
                        "صورة الطفل رقم 1",
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
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "صورة الطفل رقم 2",
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
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "صورة الطفل رقم 3",
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
                        if (formKey.currentState!.validate()) {
                          if (data == null) {
                            Get.snackbar(
                              "Error",
                              " لم يتم إضافة صورة",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(
                                seconds: 5,
                              ),
                            );
                          } else {
                            controller.addMissingData(
                              childNameController.text,
                              countryController.text,
                              ageController.text,
                              cityController.text,
                              parentNameController.text,
                              phoneController.text,
                              idController.text,
                              data,
                            );
                            setState(() {
                              controller.getAllData();
                            });
                            //3uza 2dif function el get data 34an 2dif  elgdid
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const missingChildrenScreen(),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'بلغ الأن',
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
          currentIndex: 1,
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
