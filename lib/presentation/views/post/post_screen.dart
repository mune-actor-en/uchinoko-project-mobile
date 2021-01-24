import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/views/drawerScreen.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          _Screen(),
        ],
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  String _uchinoko = 'Ryuk';
  String _privacy = '公開';

  File _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    print("init State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: size.height),
          child: Column(
            children: [
              /// Appbar
              Container(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('うちの子 投稿'),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryGreen,
                            ),
                            Text('uchinoko island'),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '投稿',
                      style: TextStyle(color: Colors.lightBlue),
                    )
                  ],
                ),
              ),

              /// 画像選択
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 12),
                child: Stack(
                  children: [
                    Container(
                      height: size.width * 0.6,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: _image == null
                          ? null
                          : Image.file(_image, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 6,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          color: Color(0xFFF5F6F9),
                          onPressed: () {
                            print('pressed');
                            getImageFromGallery();
                          },
                          // child: Icon(Icons.camera_alt_outlined),
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// うちの子 選択
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _uchinoko,
                  items: <String>['Ryuk', 'Jack', 'Sarah'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (String val) {
                    setState(() {
                      _uchinoko = val;
                    });
                  },
                ),
              ),

              /// 推しポイント
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextField(
                  minLines: 7,
                  maxLines: 12,
                  decoration: InputDecoration.collapsed(
                    hintText: '推しポイントをここに記入...',
                    border: InputBorder.none,
                  ),
                ),
              ),

              /// 公開・非公開
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _privacy,
                  items: <String>['公開', '非公開'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (String val) {
                    setState(() {
                      _privacy = val;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
