import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/category_dummy_data.dart';
import '../model/category_model.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  List<CategoryModel> categories = [];

  void loadCategories() {
    categories = List.from(CategoryDummyData.categories);
    emitLoaded();
  }

  void addCategory(CategoryModel category) {
    categories.add(category);
    emitLoaded();
  }

  void emitLoaded() {
    emit(CategoryLoaded(categories: categories));
  }
}
