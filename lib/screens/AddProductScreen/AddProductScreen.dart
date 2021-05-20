
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';

class AddProductScreen extends StatefulWidget {
  static final routeName = '/add';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  String thumbnail;
  List<String> images = [];
  final ImagePicker _picker = ImagePicker();
  String _error = 'No Error Dectected';
  var dio = Dio();
  final _productName = new TextEditingController();
  final _price = new TextEditingController();
  final _unit = new TextEditingController();
  final _vendor = new TextEditingController();
  final _description = new TextEditingController();
  String currentUserId;
  List<dynamic> category = [];

  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      currentUserId = prefs.getString('sellerId');
    });
    super.initState();
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
      dio.post(
        '$api_url/product/create', 
        data: {
          'sellerId': currentUserId,
          'productName': _productName.text,
          'description': _description.text,
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(value.data['msg']),
            )
          );
        } else {
          Navigator.pushNamed(context, HomeScreen.routeName);
        }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: _productName,
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
                controller: _price,
                keyboardType: TextInputType.number,
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
                controller: _unit,
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
                controller: _vendor,
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
                controller: _description,
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
    //Thumbnail Image
              Text('Chọn ảnh bìa'),
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
              Text('Ảnh sản phẩm'),
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
                  dataSource: [
                    {
                      "display": "Trang phục",
                      "value": "Trang phục",
                    },
                    {
                      "display": "Đồ gia dụng",
                      "value": "Đồ gia dụng",
                    },
                    {
                      "display": "Thiết bị điện tử",
                      "value": "Thiết bị điện tử",
                    },
                    {
                      "display": "Trang sức",
                      "value": "Trang sức",
                    },
                    {
                      "display": "Đồ chơi",
                      "value": "Đồ chơi",
                    },
                    {
                      "display": "Khác",
                      "value": "Khác",
                    },
                  ],
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
      bottomNavigationBar: BottomNavBar(2),
    );
  }
}