// main.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Models
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String thumbnail;
  final String category;
  final List<String> tags;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.category,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      rating: double.parse(json['rating'].toString()),
      thumbnail: json['thumbnail'],
      category: json['category'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

// Controllers
class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  void setUsername(String value) => username.value = value;
  void setPassword(String value) => password.value = value;

  bool login() {
    return username.value == 'admin' && password.value == 'Pass@123';
  }
}

class UserController extends GetxController {
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;
  var profileImagePath = ''.obs;

  void updateUsername(String value) => username.value = value;
  void updatePassword(String value) => password.value = value;
  void updateProfileImage(String path) => profileImagePath.value = path;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }
}

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

// Views
class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => authController.setUsername(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) => authController.setPassword(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (authController.login()) {
                      Get.put(UserController());
                      Get.to(() => HomePage());
                    } else {
                      Get.snackbar(
                        'Error',
                        'Invalid username or password',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Get.bottomSheet(
                FilterSheet(),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Get.to(() => ProfilePage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar (Optional task #5)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => productController.updateSearchQuery(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (productController.filteredProducts.isEmpty) {
                return Center(child: Text('No products found'));
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
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Icon(Icons.error));
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '${product.rating}',
                                    style: TextStyle(fontSize: 12),
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
              Text('Filter Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Obx(() => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: Text('All'),
                selected: productController.selectedCategory.isEmpty,
                onSelected: (selected) {
                  if (selected) {
                    productController.updateCategory('');
                  }
                },
              ),
              ...productController.categories.map((category) => FilterChip(
                label: Text(category),
                selected: productController.selectedCategory.value == category,
                onSelected: (selected) {
                  if (selected) {
                    productController.updateCategory(category);
                  } else {
                    productController.updateCategory('');
                  }
                },
              )).toList(),
            ],
          )),
          SizedBox(height: 20),
          Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Obx(() => Column(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${productController.selectedPriceRange.value.start.toStringAsFixed(0)}'),
                  Text('\$${productController.selectedPriceRange.value.end.toStringAsFixed(0)}'),
                ],
              ),
            ],
          )),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  productController.resetFilters();
                },
                child: Text('Reset Filters'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Apply Filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final UserController userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => userController.profileImagePath.isEmpty
                  ? CircleAvatar(
                radius: 60,
                child: Icon(Icons.person, size: 60),
              )
                  : CircleAvatar(
                radius: 60,
                backgroundImage: FileImage(File(userController.profileImagePath.value)),
              ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt),
                    label: Text('Camera'),
                    onPressed: () {
                      userController.pickImage(ImageSource.camera);
                    },
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library),
                    label: Text('Gallery'),
                    onPressed: () {
                      userController.pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                initialValue: userController.username.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
                onChanged: (value) => userController.updateUsername(value),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                initialValue: userController.password.value,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                onChanged: (value) => userController.updatePassword(value),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar(
                      'Success',
                      'Profile updated successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}