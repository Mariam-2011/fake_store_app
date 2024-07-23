import 'package:bloc/bloc.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/data/repositeries/product_repositery.dart';
import 'package:fake_store/domain/product_cubit/products_states.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(IntialState());

  List<ProductModel> list_product = [];
  //fun to get data from data layer (repositery)
  void fetchData() async {
    emit(LoadingState());
    try {
      list_product = await ProductRepositery.getAllProducts();
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
