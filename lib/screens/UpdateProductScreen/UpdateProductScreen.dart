import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/screens/OrderScreen/OrderScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';

class UpdateProductScreen extends StatefulWidget {
  static final routeName = '/update';
  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  Map data = {};

  String thumbnail;
  List<String> images = [];
  final ImagePicker _picker = ImagePicker();
  String _error = 'No Error Dectected';
  var dio = Dio();
  TextEditingController _productName, _price, _unit, _vendor, _description;
  String productId;
  SharedPreferences prefs;
  List<dynamic> category = [];

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    Future.delayed(Duration.zero, () {
        dynamic data = ModalRoute.of(context).settings.arguments;
        List<dynamic> listImgs = data['productImages'];
        setState(() {
          productId = data['_id'];
          thumbnail = data['thumbnail'];
          images = listImgs.map((e) => e.toString()).toList();
          category = data['categories'];
          _productName = new TextEditingController(text: data['productName']);
          _price = new TextEditingController(text: data['price'].toString());
          _unit = new TextEditingController(text: data['unit']);
          _vendor = new TextEditingController(text: data['vendor']);
          _description = new TextEditingController(text: data['description']);
        });
        
      }
    );
  }

  Future<void> _getAsset() async {

    List<Asset> assets = await selectImagesFromGallery();
    List<Future> futures = [];
    for (Asset asset in assets) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath),
      });
      futures.add(
        dio.post(
          '$imgur_url', 
          data: formData, 
          options: Options(
            headers: {
              Headers.wwwAuthenticateHeader: 'Client-ID $clientId',
              'Accept': "*/*"
            }
          )
        )
      );
    }
    if (!mounted) return;

    Future.wait(futures).then((value) {
      List<String> listPaths = [];
      for (dynamic res in value) {
        final Map mapResponse = json.decode(res.toString());
        if (mapResponse['success']) {
          final Map data = mapResponse['data'];
          print(data);
          listPaths.add(data['link']);
        }
      }
      setState(() {
        images = listPaths;
      });
    });
  }

  Future<void> _getThumbnailAsset() async {

    List<Asset> assets = await selectThumbnailImagesFromGallery();
    final thumbnailImage = await FlutterAbsolutePath.getAbsolutePath(assets[0].identifier);
    if (!mounted) return;
    print(thumbnailImage);
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(thumbnailImage),
    });
    dio.post('$imgur_url', data: formData, options: Options(
      headers: {
        Headers.wwwAuthenticateHeader: 'Client-ID $clientId',
        'Accept': "*/*"
      }
    )).then((value) {
      if (value.data['success']) {
        dynamic data = value.data['data'];
        print(data['link']);
        setState(() {
          thumbnail = data['link'];
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<Asset>> selectImagesFromGallery() async {
    return await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: "#FF147cfa",
        statusBarColor: "#FF147cfa",
      ),
    );
  }

  Future<List<Asset>> selectThumbnailImagesFromGallery() async {
    return await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: "#FF147cfa",
        statusBarColor: "#FF147cfa",
      ),
    );
  }

  Future<void> uploadProduct() async {
    if (_productName.text == '' || _vendor.text == '' || _price.text == '' || _unit.text == '' || _description.text == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Vui lòng điền đầy đủ thông tin"),
            // content: Text(""),
          )
      );
    } else if(thumbnail == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Vui lòng chọn ảnh bìa"),
            // content: Text(""),
          )
      );
    } else {
      dio.put(
          'http://${ip}:${api_port}/product/$productId',
          data: {
            'sellerId': prefs.getString('sellerId'),
            'productName': _productName.text,
            'description': _description.text,
            'categories': [],
            'productImages': images,
            'thumbnail': thumbnail,
            'price': int.parse(_price.text),
            'unit': _unit.text,
            'vendor': _vendor.text,
            'categories': category
          }
      ).then((value) {
        final success = value.data['success'];
        if (!success) {
          print( value.data['msg']);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Update product fail"),
              )
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (Route<dynamic> route) => false,);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //after get the data from get request, set the text for all variables like below so that the old data can be display in the update site
    //the data of the product can be set here
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật thông tin sản phẩm"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("Tên sản phẩm"),
                SizedBox(height: 10),
                TextFormField(
                    controller: _productName,
                    autofocus: false,
                    decoration: InputDecoration(
                      // hintText:_productName.text,
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: _productName.text,
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
                Text("Giá"),
                SizedBox(height: 10),
                TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                      // hintText: 'Giá',
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: "Giá",
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
                Text("Đơn vị"),
                SizedBox(height: 10),
                TextFormField(
                    controller: _unit,
                    autofocus: false,
                    decoration: InputDecoration(
                      // hintText: 'Đơn vị',
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: "Đơn vị",
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
                Text("Thương hiệu"),
                SizedBox(height: 10),
                TextFormField(
                    controller: _vendor,
                    autofocus: false,
                    decoration: InputDecoration(
                      // hintText: 'Thương hiệu',
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: "Thương hiệu",
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
                Text("Mô tả"),
                SizedBox(height: 10),
                TextFormField(
                    controller: _description,
                    maxLines: 3,
                    decoration: InputDecoration(
                      // hintText: 'Mô tả',
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: "Mô tả",
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
                //Thumbnail Image
                SizedBox(height: 10),
                Text('Cập nhật ảnh bìa'),
                thumbnail != null ?  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: Image(
                          image: NetworkImage(thumbnail),
                          width: 90.0,
                          height: 90.0,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 0,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                thumbnail = null;
                              });
                            },
                            child: Icon(
                                Icons.close,
                                color: Color.fromRGBO(231, 76, 60,1.0)
                            )
                        ),
                      ),
                    ]
                ) : GestureDetector(
                  onTap: _getThumbnailAsset,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                          onTap: _getThumbnailAsset,
                          child: Icon(Icons.add)
                      ),
                    ),
                  ),
                ),
                // image list
                Text('Cập nhật ảnh sản phẩm'),
                Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    children: images.map((image) => Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                              ),
                            ),
                            child: Image(
                              image: NetworkImage(image),
                              width: 90.0,
                              height: 90.0,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 0,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    images.removeWhere((img) => img == image);
                                  });
                                },
                                child: Icon(
                                    Icons.close,
                                    color: Color.fromRGBO(231, 76, 60,1.0)
                                )
                            ),
                          ),
                        ])
                    ).toList()
                ),
                GestureDetector(
                  onTap: _getAsset,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                          onTap: _getThumbnailAsset,
                          child: Icon(Icons.add)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Colors.blue,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.blue,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Danh mục",
                      style: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Chọn danh muc cho sản phẩm';
                      }
                      return null;
                    },
                    dataSource: categories_list,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Please choose one or more'),
                    initialValue: category,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                ),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadProduct,
        child: const Icon(Icons.cloud_upload),
      ),
    );
  }
}
