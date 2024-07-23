// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:fake_store/authentication/presentation/screens/profile_screen.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/data/repositeries/product_repositery.dart';
import 'package:fake_store/domain/product_cubit/products_cubit.dart';
import 'package:fake_store/domain/product_cubit/products_states.dart';
import 'package:fake_store/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final UserModel userData;
  ProductScreen({super.key, required this.userData});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var code = context.locale.languageCode;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   var code = context.locale.languageCode;
      //   if (code == 'en') {
      //     setState(() {
      //       context.setLocale(Locale('ar'));
      //     });
      //   } else {
      //     setState(() {
      //       context.setLocale(Locale('en'));
      //     });
      //   }
      // }),
      appBar: AppBar(
        foregroundColor: Colors.white60,
        backgroundColor: Colors.black,
        title: Text(context.tr('title'), style: GoogleFonts.notoKufiArabic()),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (code == 'en') {
                    context.setLocale(Locale('ar'));
                  } else {
                    context.setLocale(Locale('en'));
                  }
                });
              },
              icon: Icon(Icons.language)),
          Text(
            code == 'en' ? "EN" : "AR",
          ),
          // Text("My Profile"),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen(userData: widget.userData);
                  },
                ));
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Center(
        child: BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Text('Errorrrrrrrrrrrr'),
              );
            }
            var cubit = context.read<ProductsCubit>();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ProductItemWidget(product: cubit.list_product[index]);
              },
              itemCount: cubit.list_product.length,
            );
          },
          // )(

          // ),
        ),
      ),
    );
  }
}

//mulit language
// text('${counter.tr('counter')}$counter')
