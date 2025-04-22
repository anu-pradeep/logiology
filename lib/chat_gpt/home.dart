import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/chat_gpt/pdt_cntrlr.dart';

class HomeView extends StatelessWidget {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              productController.filterBy(category: 'phone', maxPrice: 500);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.filteredProducts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          itemCount: productController.filteredProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final product = productController.filteredProducts[index];
            return Card(
              child: Column(
                children: [
                  Image.network(product.thumbnail, height: 100),
                  Text(product.title),
                  Text('\$${product.price}'),
                  Text('⭐ ${product.rating}'),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
