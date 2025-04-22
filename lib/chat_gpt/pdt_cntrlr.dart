import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logiology/chat_gpt/pdt_listing.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['products'] as List;
      products.value = data.map((json) => Product.fromJson(json)).toList();
      filteredProducts.value = products;
    }
  }

  void filterBy({String? category, double? maxPrice}) {
    filteredProducts.value = products.where((product) {
      final categoryMatch = category == null || product.title.toLowerCase().contains(category.toLowerCase());
      final priceMatch = maxPrice == null || product.price <= maxPrice;
      return categoryMatch && priceMatch;
    }).toList();
  }
}
