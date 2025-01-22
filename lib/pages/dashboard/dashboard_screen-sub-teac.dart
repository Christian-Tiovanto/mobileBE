// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_list.dart';
import 'package:mobile_be/pages/attendance/attendancescreen.dart';
import 'package:mobile_be/pages/dashboard/drawer-home-teacher.dart';
import 'package:mobile_be/pages/dashboard/drawer-subj-teacher.dart';
import 'package:mobile_be/pages/grade/choose-class_screen_subj_teacher-assign.dart';
import 'package:mobile_be/pages/grade/choose-class_screen_subj_teacher-grade.dart';
import 'package:mobile_be/pages/grade/grade-subj-teacher.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:mobile_be/widget/ImageStreamWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardSubjTeacher extends StatefulWidget {
  const DashboardSubjTeacher({super.key});

  @override
  State<DashboardSubjTeacher> createState() => _DashboardSubjTeacherState();
}

class _DashboardSubjTeacherState extends State<DashboardSubjTeacher> {
  String? _jwtToken;
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  late SharedPreferences _prefs;
  Map<String, dynamic>? _jwtPayload;
  bool _isLoading = true;

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
          print('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Banner Ad Failed to Load: $error');
        },
      ),
    );

    _bannerAd.load();
  }

  Future<void> _pickImageFromGallery() async {
    // Check Android version
    final androidVersion = Platform.version.split(' ')[0];
    final isAndroid13OrHigher = int.parse(androidVersion.split('.')[0]) >= 13;

    if (isAndroid13OrHigher) {
      // For Android 13 (API 33) and above
      var status = await Permission.photos.request();
      if (status.isGranted) {
        // Access gallery
        final returnedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (returnedImage != null) {
          setState(() {
            _selectedImage = File(returnedImage.path);
          });
        }
      } else if (status.isDenied) {
        // Handle denied permission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gallery access denied")),
        );
      } else if (status.isPermanentlyDenied) {
        // Open app settings if permission is permanently denied
        openAppSettings();
      }
    } else {
      // For Android versions 10–12 (API 29-32)
      var status2 = await Permission.storage.request();

      if (status2.isGranted) {
        // Access gallery
        final returnedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (returnedImage != null) {
          setState(() {
            _selectedImage = File(returnedImage.path);
          });
        }
      } else if (status2.isDenied) {
        // Handle denied permission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gallery access denied")),
        );
      } else if (status2.isPermanentlyDenied) {
        // Open app settings if permission is permanently denied
        openAppSettings();
      }
    }
  }

  Future<void> _loadJwtToken() async {
    // Retrieve the stored token
    final _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    print('token di loadjwttoken');
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    print('masih masok sini');
    if (token != null) {
      setState(() {
        _jwtToken = token;
        _jwtPayload = decodeJwtPayload(token);
        _isLoading = false;
      });
    }
  }

  Future _removeData() async {
    print("kepanggil gak sih");
    _prefs = await SharedPreferences.getInstance();
    bool removed = await _prefs.remove('token');
    if (removed) {
      print(_prefs.getString('token'));
      setState(() {});
      print('Data removed successfully!');
    } else {
      print('Error removing data.');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJwtToken();
    _loadBannerAd();
  }

  File? _selectedImage = null;
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      drawer: DrawerSubjTeacher(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0), // Apply padding here
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 50,
              ),
            ),
          );
        }),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('image/bg_mobile_be.jpg'))),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber),
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome Back"),
                          Text(
                            'Subject Teachers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ],
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.amber,
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      child: ImageStreamWidget(
                                          imageUrl:
                                              '/api/v1/teacher/${_jwtPayload!['id']}/photo')),
                                  ElevatedButton(
                                      onPressed: () {
                                        _pickImageFromGallery();
                                      },
                                      child: Text('choose image'))
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (_selectedImage == null) {
                                    return Navigator.pop(context, 'OK');
                                  }
                                  final response = await TeacherService()
                                      .updateTeacherPhoto(
                                          _jwtPayload!['id'], _selectedImage!);
                                  print("response di update image berhasi");
                                  print(response);
                                  Navigator.pop(context, 'OK');
                                  setState(() {});
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                                child: ImageStreamWidget(
                                    imageUrl:
                                        '/api/v1/teacher/${this._jwtPayload!['id']}/photo'))),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseClassSubjTeacherGradePage()));
                                    // Navigator.pushNamed(
                                    //     context, '/choose-class-grade');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/qualification.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Grade",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/announcements');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Image(
                                      image: AssetImage('image/marketing.png'),
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                    // child: Icon(
                                    //   Icons.assignment_turned_in_sharp,
                                    //   color: Colors.white,
                                    //   size: 80,
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Announcements",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseClassSubjTeacherAssignmentPage()));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.assignment_turned_in_sharp,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Assignment",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                if (_isBannerAdLoaded)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
