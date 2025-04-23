import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 2000.0.obs;
  var selectedPriceRange = RangeValues(0.0, 2000.0).obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> productList = data['products'];

        products.value = productList.map((item) => Product.fromJson(item)).toList();
        filteredProducts.value = List.from(products);

        // Extract unique categories
        final Set<String> uniqueCategories = {};
        for (var product in products) {
          uniqueCategories.add(product.category);
        }
        categories.value = uniqueCategories.toList()..sort();

        // Find min and max price
        if (products.isNotEmpty) {
          minPrice.value = products.map((p) => p.price).reduce((a, b) => a < b ? a : b);
          maxPrice.value = products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
          selectedPriceRange.value = RangeValues(minPrice.value, maxPrice.value);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void filterProducts() {
    filteredProducts.value = products.where((product) {
      final matchesCategory = selectedCategory.isEmpty || product.category == selectedCategory.value;
      final matchesPrice = product.price >= selectedPriceRange.value.start &&
          product.price <= selectedPriceRange.value.end;
      final matchesSearch = searchQuery.isEmpty ||
          product.title.toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesCategory && matchesPrice && matchesSearch;
    }).toList();
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  void updatePriceRange(RangeValues range) {
    selectedPriceRange.value = range;
    filterProducts();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void resetFilters() {
    selectedCategory.value = '';
    selectedPriceRange.value = RangeValues(minPrice.value, maxPrice.value);
    searchQuery.value = '';
    filterProducts();
  }
}