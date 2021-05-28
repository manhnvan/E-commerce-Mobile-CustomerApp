import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/components/ImagePreviewer.dart';
import 'package:seller_app/components/ImageSelector.dart';
import 'package:seller_app/components/ProductField.dart';
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
  // ignore: must_call_super
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
    });
  }

  Future<void> _getAsset() async {
    List<Asset> assets = await selectImagesFromGallery();
    List<Future> futures = [];
    for (Asset asset in assets) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath),
      });
      futures.add(dio.post('$imgur_url',
          data: formData,
          options: Options(headers: {
            Headers.wwwAuthenticateHeader: 'Client-ID $clientId',
            'Accept': "*/*"
          })));
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
    final thumbnailImage =
        await FlutterAbsolutePath.getAbsolutePath(assets[0].identifier);
    if (!mounted) return;
    print(thumbnailImage);
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(thumbnailImage),
    });
    dio
        .post('$imgur_url',
            data: formData,
            options: Options(headers: {
              Headers.wwwAuthenticateHeader: 'Client-ID $clientId',
              'Accept': "*/*"
            }))
        .then((value) {
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
    if (_productName.text == '' ||
        _vendor.text == '' ||
        _price.text == '' ||
        _unit.text == '' ||
        _description.text == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Vui lòng điền đầy đủ thông tin"),
                // content: Text(""),
              ));
    } else if (thumbnail == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Vui lòng chọn ảnh bìa"),
                // content: Text(""),
              ));
    } else {
      dio.put('$api_url/product/$productId', data: {
        'sellerId': prefs.getString('sellerId'),
        'productName': _productName.text,
        'description': _description.text,
        'categories': [],
        'productImages': images,
        'thumbnail': thumbnail,
        'price': int.parse(_price.text),
        'unit': _unit.text,
        'vendor': _vendor.text,
        // ignore: equal_keys_in_map
        'categories': category
      }).then((value) {
        final success = value.data['success'];
        if (!success) {
          print(value.data['msg']);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Update product fail"),
                  ));
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (Route<dynamic> route) => false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //after get the data from get request, set the text for all variables like below so that the old data can be display in the update site
    //the data of the product can be set here
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Cập nhật sản phẩm"),
        gradient: color_gradient_primary,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(space_medium),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Product's name here~~
                ProductField('Tên sản phẩm', _productName, null, 1),

                //Product's price here~~
                ProductField(
                    'Giá thành sản phẩm', _price, TextInputType.number, 1),

                //Product's unit here~~
                ProductField('Đơn vị', _unit, null, 1),

                //Product's brand here~~
                ProductField('Thương hiệu', _vendor, null, 1),

                //Product's description here~~
                ProductField('Mô tả sản phẩm', _description, null, 5),

                //Thumbnail image here~~
                Text('Cập nhật ảnh bìa',
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: space_medium),
                thumbnail != null
                    //This stack holds the product's thumbnail and the close button~~
                    ? Stack(clipBehavior: Clip.none, children: [
                        //This container contains the image itself~~
                        ImagePreviewer(thumbnail),

                        //This is the close button :v
                        Positioned(
                          top: -space_small - 2,
                          right: -space_small - 2,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  thumbnail = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(space_tiny - 1),
                                decoration: BoxDecoration(
                                    color: color_white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1000)),
                                    boxShadow: [box_shadow_black]),
                                child: Icon(Icons.close_rounded,
                                    color: color_primary_darker),
                              )),
                        ),
                      ])
                    : ImageSelector(_getThumbnailAsset),

                SizedBox(height: space_huge),

                //Product's image list here~~
                Text('Cập nhật ảnh sản phẩm',
                    style: Theme.of(context).textTheme.bodyText1),

                SizedBox(height: space_medium),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: images
                          .map((image) => Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: space_small),
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                                  ImagePreviewer(image),
                                  Positioned(
                                      top: -space_small - 2,
                                      right: -space_small - 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            images.removeWhere(
                                                (img) => img == image);
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(space_tiny - 2),
                                          decoration: BoxDecoration(
                                              color: color_white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1000)),
                                              boxShadow: [box_shadow_black]),
                                          child: Icon(Icons.close_rounded,
                                              color: color_primary_darker),
                                        ),
                                      )),
                                ]),
                              ))
                          .toList()),
                ),

                //This is the image picker~~
                Padding(
                  padding: EdgeInsets.symmetric(vertical: space_medium),
                  child: ImageSelector(_getAsset),
                ),

                SizedBox(height: space_big),

                //Product's categories here~~
                Container(
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: color_secondary,
                    chipLabelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: color_white,
                      fontSize: 15
                    ),
                    dialogTextStyle: Theme.of(context).textTheme.bodyText1,
                    checkBoxActiveColor: color_secondary,
                    checkBoxCheckColor: color_white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(border_radius_big))),
                    title: Text(
                      "Danh mục",
                      style: Theme.of(context).textTheme.bodyText1,
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
                    okButtonLabel: 'Tiếp',
                    cancelButtonLabel: 'Hủy',
                    hintWidget: Text('Chọn một hoặc hơn các danh mục',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 14
                      ),
                    ),
                    initialValue: category,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                ),
              ]),
        ),
      ),

      //Update button here~~
      floatingActionButton: FloatingActionButton(
          onPressed: uploadProduct,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, gradient: color_gradient_primary),
              child: Icon(Icons.upload_rounded, size: 30))),
    );
  }
}
