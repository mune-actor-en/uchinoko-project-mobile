// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uchinoko_project_mobile/application/providers.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/post_model.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/all/drawer_screen.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/index/timeline_screen.dart';

class TimelinePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          _Screen(petsList: context.read(petsNotifierProvider.state).pets),
        ],
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  final List<PetModel> petsList;

  const _Screen({this.petsList});

  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> with AfterLayoutMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  PetModel _uchinoko;
  String _privacy = '公開';

  List<PetModel> pets;

  File _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  String imgBase64;
  int petId;
  String description;
  bool isPublished;


  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      var imagePath = pickedFile.path;
      _image = File(imagePath);
      imgBase64 = imagePath;
    });
  }

  void printProperty() {
    print('======================================================');
    print('imgBase64: $imgBase64');
    print('petId: $petId');
    print('description: $description');
    print('isPublished: $isPublished');
    print('======================================================');
  }

  Future<void> createPost(BuildContext context) async {
    final post = PostModel(
      imagePath: imgBase64,
      description: description,
      isPublished: isPublished,
      userId: context.read(sessionNotifierProvider).getUserId(),
      petId: petId,
    );
    final jwt = context.read(sessionNotifierProvider.state).session.token;
    await context.read(timelineNotifierProvider).createPost(post, jwt);
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => TimelineScreen()),
    );

  }

  @override
  void initState() {
    imgBase64 = '';
    petId = 0;
    description = '';
    isPublished = true;
    pets = [];
    _uchinoko = null;
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    List<PetModel> _list = [];
    var userId = context.read(sessionNotifierProvider.state).session.uid;
    widget.petsList.forEach((e) {
      if (e.userId == userId) _list.add(e);
    });

    setState(() {
      pets = _list;
      _uchinoko = pets.first;
    });
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
          child: Form(
            key: _formKey,
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
                      InkWell(
                        onTap: () {
                          _formKey.currentState.save();
                          printProperty();
                          createPost(context);
                          },
                        child: Text(
                          '投稿',
                          style: TextStyle(color: Colors.lightBlue),
                        ),
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
                  child: DropdownButton<PetModel>(
                    isExpanded: true,
                    value: _uchinoko,

                    items: pets.map((PetModel pet) {
                      // var state = context.read(sessionNotifierProvider.state);
                      // if (pet.userId != state.session.uid) return null;
                      return DropdownMenuItem<PetModel>(
                        value: pet,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(pet.name),
                        ),
                      );
                    }).toList(),

                    onChanged: (PetModel pet) {
                      setState(() {
                        _uchinoko = pet;
                        petId = _uchinoko.id;
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
                  child: TextFormField(
                    minLines: 7,
                    maxLines: 12,
                    decoration: InputDecoration.collapsed(
                      hintText: '推しポイントをここに記入...',
                      border: InputBorder.none,
                    ),
                    onSaved: (val) {
                      description = val;
                    },
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
                        isPublished = _privacy == '公開';
                      });
                    },
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
