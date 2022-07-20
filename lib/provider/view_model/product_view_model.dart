import 'package:flutter/material.dart';
import 'package:mvvm_example/api/product/product_api.dart';

import '../../model/product_model.dart';

class ProductViewModel extends ChangeNotifier{

  ProductModel? _productModel;
  bool? _isLoading = true;

  ProductModel? get productModel => _productModel;
  bool? get isLoading => _isLoading;

  Future<void> getProduct() async{

    try{
      _isLoading = true;
      final response = await ProductApi().getProduct();
      _productModel = response;

    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
    }
  }
}