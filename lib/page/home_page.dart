import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvvm_example/api/product/product_api.dart';
import 'package:mvvm_example/provider/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ProductViewModel? _productViewModel;
  @override
  void initState() {
    _productViewModel = Provider.of<ProductViewModel>(context,listen: false);
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _productViewModel?.getProduct();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(padding:const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Consumer<ProductViewModel>(
          builder: (context, productViewModel, child) {
            if(productViewModel.isLoading!){
              return const Center(child: CircularProgressIndicator(),);
            }

            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: productViewModel.productModel?.products.length,
              itemBuilder: (context, index) {
                return Text('${productViewModel.productModel?.products[index].id}');
            },);
          },
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await ProductApi().postProduct(context: context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
