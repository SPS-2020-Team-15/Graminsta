import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImageWidget extends StatefulWidget {
  PickImageWidget() : super();

  final String title = "Pick Image";

  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  final picker = ImagePicker();
  File selectedImage;

  Future pickImageFromGallery(source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () async {
              Navigator.pop(context, selectedImage);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: selectedImage == null
                  ? Text('No image selected.')
                  : Image.file(selectedImage, width: 300, height: 300),
            ),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
