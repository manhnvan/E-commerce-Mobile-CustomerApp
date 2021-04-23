import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  List<File> images = [];
  final ImagePicker _picker = ImagePicker();

  void _takePhoto(ImageSource source) async {
    final takenPhoto = await _picker.getImage(source: source);
    if (takenPhoto != null) {
      setState(() {
        images.add(File(takenPhoto.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng bán sản phẩm"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Tên sản phẩm',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Tên sản phẩm",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(127, 140, 141,1.0), 
                      width: 1.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 204, 113,1.0),
                      width: 1.5,
                    ),
                  ),
                )
              ),
              
              SizedBox(height: 10),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Giá',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Giá",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(127, 140, 141,1.0), 
                      width: 1.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 204, 113,1.0),
                      width: 1.5,
                    ),
                  ),
                )
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Đơn vị',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Đơn vị",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(127, 140, 141,1.0), 
                      width: 1.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 204, 113,1.0),
                      width: 1.5,
                    ),
                  ),
                )
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Thương hiệu',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Thương hiệu",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(127, 140, 141,1.0), 
                      width: 1.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 204, 113,1.0),
                      width: 1.5,
                    ),
                  ),
                )
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Mô tả',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Mô tả",
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(127, 140, 141,1.0), 
                      width: 1.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 204, 113,1.0),
                      width: 1.5,
                    ),
                  ),
                )
              ),

              Wrap(
                direction: Axis.horizontal,
                spacing: 10.0,
                children: images.map((image) => Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(image.path))
                        )
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            images.removeWhere((img) => img == image);
                          });
                        },
                        child: Icon(Icons.delete)
                      ),
                    ),
                  ])
                ).toList(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            builder: (builder) => Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _takePhoto(ImageSource.camera);
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _takePhoto(ImageSource.gallery);
                    }, 
                    child: Icon(
                      Icons.collections,
                      size: 40,
                    )
                  )
                ],
              ),
            )
          );
        },
        child: Icon(Icons.camera),
        backgroundColor: Colors.blue
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}