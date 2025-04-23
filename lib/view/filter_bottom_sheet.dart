import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/utils/color.dart';
import 'package:logiology/utils/heading_text.dart';

import '../controllers/product_controller.dart';
import '../utils/common_button.dart';

class FilterSheet extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadText(heading: 'Filter Products', fontSize: 20),
              IconButton(
                icon: Icon(Icons.close, color: ColorClass.borderColor),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          SizedBox(height: 20),
          HeadText(heading: 'Category', fontSize: 13),

          SizedBox(height: 10),
          Obx(
            () => Wrap(
              spacing: 25,
              runSpacing: 10,
              children: [
                FilterChip(
                  label: Text(
                    'All',
                    style: TextStyle(fontFamily: 'PoppinsRegular'),
                  ),
                  selected: productController.selectedCategory.isEmpty,
                  onSelected: (selected) {
                    if (selected) {
                      productController.updateCategory('');
                    }
                  },
                  backgroundColor: ColorClass.whiteColor,
                  selectedColor: ColorClass.greenColor,
                ),
                ...productController.categories
                    .map(
                      (category) => FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 15,
                            color: ColorClass.blackColor,
                          ),
                        ),
                        selected:
                            productController.selectedCategory.value ==
                            category,
                        onSelected: (selected) {
                          if (selected) {
                            productController.updateCategory(category);
                          } else {
                            productController.updateCategory('');
                          }
                        },
                        backgroundColor: ColorClass.whiteColor,
                        selectedColor: ColorClass.greenColor,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          SizedBox(height: 20),
          HeadText(heading: 'Price Range', fontSize: 13),
          SizedBox(height: 10),
          Obx(
            () => Column(
              children: [
                RangeSlider(
                  values: productController.selectedPriceRange.value,
                  min: productController.minPrice.value,
                  max: productController.maxPrice.value,
                  divisions: 100,
                  labels: RangeLabels(
                    '\$${productController.selectedPriceRange.value.start.toStringAsFixed(0)}',
                    '\$${productController.selectedPriceRange.value.end.toStringAsFixed(0)}',
                  ),
                  onChanged: (values) {
                    productController.updatePriceRange(values);
                  },
                  activeColor: ColorClass.borderColor,

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${productController.selectedPriceRange.value.start.toStringAsFixed(0)}',
                      style: TextStyle(fontFamily: 'PoppinsRegular'),
                    ),
                    Text(
                      '\$${productController.selectedPriceRange.value.end.toStringAsFixed(0)}',
                      style: TextStyle(fontFamily: 'PoppinsRegular'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonElevatedButton(buttonText: 'Reset',
                  buttonColor: ColorClass.whiteColor, textColor: ColorClass.blackColor,
                  onPressed: (){productController.resetFilters();}, fontSize: 13),


              CommonElevatedButton(
                buttonText: 'Apply',
                buttonColor: ColorClass.redColor,
                textColor: ColorClass.whiteColor,
                onPressed: () {
                  Get.back();
                },
                fontSize: 13,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
