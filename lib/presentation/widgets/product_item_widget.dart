import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/presentation/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  //create property for type bt3ha productmodel
  ProductModel product;
  ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetails(product: product);
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 150,
              color: Colors.white,
              child: Image.network(
                product.image,
                height: 150,
              ),
            ),
            Text(product.title,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            Text(
              '${product.price} \$',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
