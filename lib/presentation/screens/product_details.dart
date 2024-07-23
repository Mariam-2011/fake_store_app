import 'package:easy_localization/easy_localization.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  ProductModel product;
  ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('title'), style: GoogleFonts.notoKufiArabic()),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: 300,
                height: 150,
                color: Colors.white,
                child: Image.network(
                  product.image,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(product.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(product.description,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                '${product.price} \$',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
