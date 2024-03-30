import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/view/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  final int? indexPageCategoryDetail;
  const CategoryDetails({Key? key, required this.title, required this.indexPageCategoryDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).white.make(),
            ),
            body: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => 
                            categoriesList[index]
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()                                
                                .box
                                .white
                                .rounded
                                .size(200, 60)
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .make()),
                      )),
                  //item Container
                  20.heightBox,
                  Expanded(
                    child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                          Image.asset(categoryDetailsList[indexPageCategoryDetail!][index],
                              height: 200, width: 200, fit: BoxFit.cover),
                          // 10.heightBox,
                          textfpHomeScreen[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                          10.heightBox,
                          pricefpHomeScreen[index]
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                        ],
                      )
                      .box
                      .white
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .roundedSM
                      .outerShadowSm
                      // .padding(const EdgeInsets.all(12))
                      .make()
                      .onTap(() {
                        Get.to(() => ItemDetails(title: "Hanh Item"));
                      });
                    },
                  ))
                ],
              ),
            )));
  }
}
