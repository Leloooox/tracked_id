import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../API/Controller.dart';
import '../WelcomeHomePage.dart';
import 'Update_data.dart';

// ignore: camel_case_types
class myPostsScreen extends StatefulWidget {
  const myPostsScreen({Key? key}) : super(key: key);

  @override
  State<myPostsScreen> createState() => _myPostsScreenState();
}

// ignore: camel_case_types
class _myPostsScreenState extends State<myPostsScreen> {
  final Controller controller = Get.put(Controller());
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // This code uses the addPostFrameCallback() method to wait until the widget is fully built before calling getAllData().
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getMyPosts();
      setState(() {
        controller.getMyPosts(); // Function to fetch the latest data
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff112031),
      appBar: AppBar(
        elevation: 20,
        toolbarHeight: 80,
        backgroundColor: const Color(0xff112031),
        actions: [
          IconButton(
            iconSize: 40,
            icon: const Image(
              image: AssetImage(
                "assets/logo.png",
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeHomePage(),
                ),
              );
            },
          ),
        ],
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          controller: searchController,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'ابحث عن شخص',
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.white54,
                size: 20,
              ),
              onPressed: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color(0xff112031),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
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
          keyboardType: TextInputType.text,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final filteredItems = controller.items.where((item) {
                  final name =
                      item['name'].toLowerCase(); // convert name to lower case
                  final query = searchQuery
                      .toLowerCase(); // convert searchQuery to lower case
                  return name.contains(query);
                }).toList();
                if (controller.isLoading.value) {
                  // Show the circular progress indicator while loading
                  return const SizedBox(
                    height: 500,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        " القضايا الخاصة بي",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(
                        endIndent: 15,
                        indent: 15,
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];

                            return Column(
                              children: [
                                Material(
                                  color: const Color(0xff112031),
                                  elevation: 20,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.05,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item['name'],
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.white,
                                                thickness: 0.1,
                                              ),
                                              MaterialButton(
                                                color: const Color(0xff24baef),
                                                minWidth: double.infinity,
                                                highlightColor:
                                                    const Color(0xff112031),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                                height: 40,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10.0,
                                                          ),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.white,
                                                            width: 0.1,
                                                          ),
                                                        ),
                                                        title: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              10,
                                                          child: Column(
                                                            children: const [
                                                              Text(
                                                                "المزيد عن الشخص",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Divider(
                                                                endIndent: 15,
                                                                indent: 15,
                                                                color: Colors
                                                                    .white,
                                                                thickness: 0.2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        content: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 180,
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    // ignore: prefer_interpolation_to_compose_strings
                                                                    "https://missing-person.online/public/images/" +
                                                                        item[
                                                                            'image'],
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          'name'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      "  : أسم الطفل",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          'governorate'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      "  : المحافظة",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          'city'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      ": المدينة",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      "${item['age']}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      ": العمر",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          'fatherName'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      ": أسم الأب",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          'phone'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      " : الهاتف",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        scrollable: true,
                                                        insetPadding:
                                                            const EdgeInsets
                                                                .all(
                                                          2,
                                                        ),
                                                        elevation: 10,
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        backgroundColor:
                                                            const Color(
                                                                0xff112031),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                              "إغلاق",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'المزيد عن الشخص',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.blue,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        update_data(
                                                                          user:
                                                                              item,
                                                                        )));
                                                      },
                                                      child: const Text(
                                                        'تعديل',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.red,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        controller
                                                            .deleteMissing(
                                                                item);
                                                      },
                                                      child: const Text(
                                                        'حذف',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 120,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "https://missing-person.online/public/images/" +
                                                    item['image'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          }),
                    ],
                  );
                }
              }),
            ),
            const SizedBox(
              height: 20,
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
    );
  }
}
