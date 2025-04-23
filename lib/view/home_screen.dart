import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/utils/color.dart';
import 'package:logiology/utils/heading_text.dart';
import 'package:logiology/view/profile_screen.dart';

import '../controllers/product_controller.dart';
import '../utils/search_field.dart';
import 'filter_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorClass.whiteColor,
        title: HeadText(heading: 'Products', fontSize: 20,),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: ColorClass.borderColor),
            onPressed: () {
              Get.bottomSheet(
                FilterSheet(),
                backgroundColor: ColorClass.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: ColorClass.borderColor),
            onPressed: () {
              Get.to(() => ProfilePage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchField(
              hintText: 'Search Products...',
              onChanged: (value) => productController.updateSearchQuery(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (productController.filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      color: ColorClass.redColor,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productController.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productController.filteredProducts[index];
                  return Card(
                    color: ColorClass.whiteColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.error,
                                    color: ColorClass.borderColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PoppinsRegular',
                                  color: ColorClass.blackColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: ColorClass.greenColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PoppinsRegular',
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: ColorClass.yellowColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${product.rating}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'PoppinsRegular',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
