// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'products.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  var imageUrlCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: "Title", hintText: "Add title"),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Description", hintText: "Add description"),
              controller: descController,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Price", hintText: "Add price"),
              controller: priceController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Image Url",
                  hintText: "Paste your image url here"),
              controller: imageUrlCont,
            ),
            const SizedBox(height: 30),
            Consumer<Products>(
              builder: (ctx, value, _) => ElevatedButton(
                // color: Colors.orangeAccent,
                // textColor: Colors.black,
                child: const Text("Add Product"),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      imageUrlCont.text.isEmpty) {
                    Toast.show("Please enter all Fields",
                        duration: Toast.lengthLong);
                  } else {
                    try {
                      value.add(
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        description: descController.text,
                        price: double.parse(priceController.text),
                        imageUrl: imageUrlCont.text,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      Toast.show("Please enter a valid price",
                          duration: Toast.lengthLong);
                      print(e);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
