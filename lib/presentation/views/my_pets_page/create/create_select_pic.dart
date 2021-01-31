// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CreateSelectPic extends StatefulWidget {
  final void Function(String) callback;

  const CreateSelectPic({
    Key key,
    this.callback,
  }) : super(key: key);

  @override
  _CreateSelectPicState createState() => _CreateSelectPicState();
}

class _CreateSelectPicState extends State<CreateSelectPic> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      var _imagePath = pickedFile.path;
      print(_imagePath);
      _image = File(_imagePath);
      widget.callback(_imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black12,
            backgroundImage: _image == null
                ? null
                : FileImage(_image),
            // : Image.file(_image),
          ),
          Positioned(
            right: -16,
            bottom: 0,
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
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
