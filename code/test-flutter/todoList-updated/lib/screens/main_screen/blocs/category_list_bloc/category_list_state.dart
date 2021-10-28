part of 'category_list_bloc.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();
}

class CategoryListInitial extends CategoryListState {
  @override
  List<Object> get props => [];
}

class CategoryListLoading extends CategoryListState {
  @override
  List<Object> get props => [];
}

class CategoryListLoaded extends CategoryListState {
  final List<CategoryModel> categories;

  CategoryListLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryListError extends CategoryListState {
  @override
  List<Object> get props => [];
}
