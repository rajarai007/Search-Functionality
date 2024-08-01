import 'package:app/model/product_model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Dio _dio = Dio();

  List<ProductModel> _product = [];

  getData({String? searchText}) async {
    String url = "https://freetestapi.com/api/v1/products";
    if (searchText != null) {
      url += '?search=$searchText';
    }
    try {
      Response res = await _dio.get(url);
      if (res.data != null) {
        List<ProductModel> products = [];
        for (var p in res.data) {
          products.add(ProductModel.fromMap(p as Map<String, dynamic>));
        }
        setState(() {
          _product = products;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Searching Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                getData(searchText: value);
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _product.length,
              itemBuilder: (context, index) {
                ProductModel product = _product[index];
                return ListTile(
                  title: Text(product!.name ?? "unnamed"),
                  leading: Image.network(product!.image.toString()),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
