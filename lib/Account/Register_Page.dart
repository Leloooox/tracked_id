import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../API/Controller.dart';
import 'Login_Page.dart';

// ignore: camel_case_types
class Register_Page extends StatefulWidget {
  const Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_PageState();
}

// ignore: camel_case_types
class _Register_PageState extends State<Register_Page> {
  // ignore: non_constant_identifier_names
  TextEditingController Name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Email = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Password = TextEditingController();
  bool passenable = true; //boolean value to track password view enable disable.
  final formKey = GlobalKey<FormState>();
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 15,
                    end: 15,
                    top: 30,
                    bottom: 30,
                  ),
                  child: Container(
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(
                            15,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "انشاء حساب",
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
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: Name,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' هذا الحقل مطلوب';
                                  } else if (value.length < 3) {
                                    return 'الاسم يجب ان يكون 3 احرف علي الاقل';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'الاسم بالكامل',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      80.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: Email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' هذا الحقل مطلوب';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'هذا الحقل غير صحيح';
                                    // ignore: unrelated_type_equality_checks
                                  }
                                  // else if (controller.message ==
                                  //     'البريد الإلكتروني مستخدم بالفعل') {
                                  //   return 'البريد الإلكتروني مستخدم بالفعل';
                                  // }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'البريد الالكتروني',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                obscureText: passenable,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: Password,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  } else if (value.length < 6) {
                                    return 'كلمة السر يجب ان تتكون من 6 احرف علي الاقل';
                                  } else if (value.length > 16) {
                                    return 'كلمة السر يجب ان تكون اقل من 16 حرف';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'كلمة المرور',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        //refresh UI
                                        if (passenable) {
                                          passenable = false;
                                        } else {
                                          passenable = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      (passenable == true
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      80.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                highlightColor: const Color(0xff112031),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    80.0,
                                  ),
                                ),
                                height: 60,
                                onPressed: () async {
                                  await controller.registerData(
                                    Name.text,
                                    Email.text,
                                    Password.text,
                                  );
                                  if (formKey.currentState!.validate()) {
                                    // ignore: unrelated_type_equality_checks
                                    if (controller.message ==
                                        'البريد الإلكتروني مستخدم بالفعل') {
                                      Get.snackbar(
                                        "Error",
                                        "${controller.message}",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(
                                          seconds: 5,
                                        ),
                                      );
                                      Email.clear();
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                color: const Color(0xff24baef),
                                minWidth: double.infinity,
                                child: const Text(
                                  'تسجيل',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 15.0,
                                      ),
                                      child: const Divider(
                                        color: Colors.white,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "أو",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                        ),
                                        child: const Divider(
                                          color: Colors.white,
                                          height: 50,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "دخول",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff24baef),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "هل قمت بالتسجيل سابقاً؟",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 15,
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
    );
  }
}
