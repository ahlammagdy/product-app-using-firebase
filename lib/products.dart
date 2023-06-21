// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Products with ChangeNotifier {
  List<Product> productsList = [];

  void add(
      {required String id,
      required String title,
      required String description,
      required double price,
      required String imageUrl}) {
    final url = Uri.parse(
        "https://products-7c916-default-rtdb.firebaseio.com/product.json");
    http
        .post(url,
            body: json.encode({
              'id': id,
              'title': title,
              'description': description,
              'price': price,
              'imageURL': imageUrl
            }))
        .then((res) {
      print(json.decode(res.body));
    });

    var reff = FirebaseDatabase.instance.ref().child("product");
    reff.set(10);

    productsList.add(Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    ));

    print(imageUrl);

    notifyListeners();
  }

  void delete(String id) {
    productsList.removeWhere((element) => element.id == id);
    notifyListeners();
    print("Item Deleted");
  }
}
