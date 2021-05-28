import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/HomeScreen/ProductDetail.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard(
      {Key key,
      this.productId,
      this.productName,
      this.image,
      this.price,
      this.vendor,
      this.sold,
      this.rate,
      this.like})
      : super(key: key);

  String productName, image, vendor, productId;
  int price, sold;
  double rate;
  int like;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetail.routeName,
            arguments: {"productId": productId});
      },
      child: ClipRRect(
        borderRadius: cardShape,
        clipBehavior: Clip.antiAlias,
        child: Container(
            margin: EdgeInsets.only(bottom: space_medium),
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(border_radius_big)),
                gradient: color_gradient_secondary,
                boxShadow: [box_shadow_black]),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: cardShape, color: color_white),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                //This is the product thumbnail :v
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 125,
                  margin: EdgeInsets.only(right: space_medium),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(border_radius_big)),
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),

                //This is the number of likes and reviews :)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Rating score here ^^
                    Text('Đánh giá: ' + rate.toString() + '/5',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13.5)),

                    SizedBox(height: space_tiny),

                    //Number of likes here ^^
                    Text('Lượt thích: ' + like.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13.5)),

                    SizedBox(height: space_medium),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Edit button :3
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              margin: EdgeInsets.only(right: space_medium),
                              padding: EdgeInsets.symmetric(
                                  vertical: space_small, horizontal: space_big),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(border_radius_big)),
                                  gradient: color_gradient_primary),
                              child: Text('Sửa',
                                  style:
                                      Theme.of(context).textTheme.headline6.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: color_white
                                      ))),
                        ),

                        //Delete button :3
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: space_small, horizontal: space_big),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: color_primary_darker
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(border_radius_big)),
                                  ),
                              child: Text('Xóa',
                                  style:
                                  Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              ]),
            )),
      ),
    );
  }
}
