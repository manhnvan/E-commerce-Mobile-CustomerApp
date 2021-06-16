import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/components/BottomNavBarVer2.dart';
import 'package:seller_app/components/ImagePreviewer.dart';
import 'package:seller_app/components/ImageSelector.dart';
import 'package:seller_app/components/ProductField.dart';
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
  List<dynamic> hiddenCategory = [];

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
    setState(() {
      hiddenCategory = [];
    });
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
    for (Asset asset in assets) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      List<int> imageBytes = File(filePath).readAsBytesSync();
      String imageString = base64Encode(imageBytes);

      var formData = FormData.fromMap({
        'image_base64': imageString,
        "language": "vi",
        "threshold": 60,
        "limit": 5
      });
      futures.add(dio.post('https://api.imagga.com/v2/tags',
          data: formData,
          options: Options(headers: {
            "Authorization": "Basic YWNjXzhiMWQ1OTlmYmFjYWQwZDpjOTUzOTliOTUyNDYyNzBiYTFmNjU1ZTFlYTkzODFkZg==",
            'Accept': "*/*"
          })));
    }
    if (!mounted) return;
    var tempCate = hiddenCategory;
    Future.wait(futures).then((value) {
      print("value: $value");
      List<String> listPaths = [];
      var index = -1;
      for (dynamic res in value) {
        index += 1;
        final Map mapResponse = json.decode(res.toString());
        if(index < assets.length){
          if (mapResponse['success']) {
            final Map data = mapResponse['data'];
            listPaths.add(data['link']);
          }
        }
        else{
          mapResponse["result"]["tags"].forEach((tag) {
            if(!tempCate.contains(tag["tag"]["vi"])){
              tempCate.add(tag["tag"]["vi"]);
            }
          });
        }
      }
      setState(() {
        images = listPaths;
        hiddenCategory = tempCate;
      });
    });
  }

  Future<void> _getThumbnailAsset() async {
    List<Asset> assets = await selectThumbnailImagesFromGallery();
    final thumbnailImage =
        await FlutterAbsolutePath.getAbsolutePath(assets[0].identifier);
    if (!mounted) return;
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
    print("Category: $hiddenCategory");
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
      dio.post('$api_url/product/create', data: {
        'sellerId': currentUserId,
        'productName': _productName.text,
        'description': _description.text,
        'productImages': images,
        'thumbnail': thumbnail,
        'price': int.parse(_price.text),
        'unit': _unit.text,
        'vendor': _vendor.text,
        'categories': category,
        'hiddenCategories': hiddenCategory
      }).then((value) {
        final success = value.data['success'];
        if (!success) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(value.data['msg']),
                  ));
        } else {
          Navigator.pushNamed(context, HomeScreen.routeName);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text("Thêm sản phẩm",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: color_white)),
          gradient: color_gradient_primary,
          automaticallyImplyLeading: false),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: space_medium,
                right: space_medium,
                top: space_medium,
                bottom: nav_height + space_medium),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Product's name here~~
                  ProductField('Tên sản phẩm', _productName, null),

                  //Product's price here~~
                  ProductField(
                      'Giá thành sản phẩm', _price, TextInputType.number),

                  //Product's unit here~~
                  ProductField('Đơn vị', _unit, null),

                  //Product's brand here~~
                  ProductField('Thương hiệu', _vendor, null),

                  //Product's description here~~
                  ProductField('Mô tả sản phẩm', _description, null),

                  //Thumbnail image here~~
                  Text('Chọn ảnh bìa',
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1000)),
                                      boxShadow: [box_shadow_black]),
                                  child: Icon(Icons.close_rounded,
                                      color: color_primary_darker),
                                )),
                          ),
                        ])
                      : ImageSelector(_getThumbnailAsset),

                  SizedBox(height: space_huge),

                  //Product's image list here~~
                  Text('Chọn ảnh sản phẩm',
                      style: Theme.of(context).textTheme.bodyText1),

                  SizedBox(height: space_medium),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        children: images
                            .map((image) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: space_small),
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

                  //Image picker here ;v
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
                      chipLabelStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: color_white, fontSize: 15),
                      dialogTextStyle: Theme.of(context).textTheme.bodyText1,
                      checkBoxActiveColor: color_secondary,
                      checkBoxCheckColor: color_white,
                      dialogShapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(border_radius_big))),
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
                      okButtonLabel: 'Tiếp',
                      cancelButtonLabel: 'Hủy',
                      hintWidget: Text(
                        'Chọn một hoặc hơn các danh mục',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 14),
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
        Positioned(
            left: 0, bottom: 0, child: BottomNavBarVer2(2, uploadProduct))
      ]),
    );
  }
}
