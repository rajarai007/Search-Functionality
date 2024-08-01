import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/model/product_model/product_model.dart';
import 'package:flutter/widgets.dart';

class HomePagewithSearch extends StatefulWidget {
  const HomePagewithSearch({super.key});

  @override
  State<HomePagewithSearch> createState() => _HomePagewithSearchState();
}

class _HomePagewithSearchState extends State<HomePagewithSearch> {
  List<ProductModel> _product = [];
  final Dio _dio = Dio();

  void _loadData({String? searchText}) async {
    String url = "https://freetestapi.com/api/v1/products";
    if (searchText != null) {
      url += "?search=$searchText";
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
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Searching"),
        ),
        body: Column(children: [_searchBar(), _buildProductListView()]));
  }

  Widget _searchBar() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.80,
      child: TextField(
        onSubmitted: (value) {
          _loadData(searchText: value);
        },
        decoration: const InputDecoration(
            hintText: "search", border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildProductListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _product.length,
        itemBuilder: (context, index) {
          ProductModel product = _product[index];
          return ListTile(
            title: Text(product.name ?? 'Unnamed Product'),
            leading: Image.network(product!.image.toString()),
          );
        },
      ),
    );
  }
}
