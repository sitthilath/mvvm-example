import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_example/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_example/provider/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductApi{

  Future<ProductModel> getProduct() async{
    try {
      final headers = {
        'Accept':'application/json',
      };

      Uri url = Uri.parse('https://dummyjson.com/products');
      var response = await http.get(url,headers: headers);

      if (kDebugMode) {
        print("getProduct:${response.statusCode}");
        print("getProduct:${response.body}");
      }
      if(response.statusCode == 200){
        return ProductModel.fromJson(jsonDecode(response.body));
      }else if(response.statusCode == 401){
        if (kDebugMode) {
          print("UnAuthication");
        }

      }else if(response.statusCode == 429){
        if (kDebugMode) {
          print("Many too request");
        }

      }
      else if(response.statusCode == 500){
        if (kDebugMode) {
          print("Server Error");
        }

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    throw Exception('error load api');
  }

  Future<void> postProduct({required BuildContext context}) async{
    try {
      final headers = {
        'Accept':'application/json',
      };

      Uri url = Uri.parse('https://dummyjson.com/products/add');
      var response = await http.post(url,headers: headers);

      if (kDebugMode) {
        print("postProduct:${response.statusCode}");
        print("postProduct:${response.body}");
      }
      if(response.statusCode == 200){
        Provider.of<ProductViewModel>(context,listen:false).getProduct();
      }else if(response.statusCode == 401){
        if (kDebugMode) {
          print("UnAuthication");
        }

      }else if(response.statusCode == 429){
        if (kDebugMode) {
          print("Many too request");
        }

      }
      else if(response.statusCode == 500){
        if (kDebugMode) {
          print("Server Error");
        }

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    throw Exception('error load api');
  }
}