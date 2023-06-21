import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_product.dart';
import 'product_details.dart';
import 'products.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;

    Widget detailCard(id, tile, desc, price, imageUrl, ctx) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => ProductDetails(id)),
          ).then(
              (id) => Provider.of<Products>(context, listen: false).delete(id));
        },
        child: Column(
          children: [
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              color: const Color.fromRGBO(115, 138, 119, 1),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 130,
                      child: Hero(
                        tag: id,
                        child: Image.network(imageUrl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(
                          tile,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(color: Colors.white),
                        SizedBox(
                          width: 200,
                          child: Text(
                            desc,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                        const Divider(color: Colors.white),
                        Text(
                          "\$$price",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Products')),
      body: prodList.isEmpty
          ? const Center(
              child: Text('No Products Added.', style: TextStyle(fontSize: 22)))
          : ListView(
              children: prodList
                  .map(
                    (item) => Builder(
                        builder: (ctx) => detailCard(item.id, item.title,
                            item.description, item.price, item.imageUrl, ctx)),
                  )
                  .toList(),
            ),
      floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor,
        ),
        child: ElevatedButton.icon(
          label: const Text("Add Product",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddProduct())),
        ),
      ),
    );
  }
}
