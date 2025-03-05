part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> productsTec;
  final PaginationMetaData metaData;
  final FilterProductParams params;

  const ProductState({
    required this.products,
    required this.productsTec,
    required this.metaData,
    required this.params,
  });
}

class ProductInitial extends ProductState {
  const ProductInitial({
    required super.products,
    required super.productsTec,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState {
  const ProductEmpty({
    required super.products,
    required super.productsTec,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading({
    required super.products,
    required super.productsTec,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  const ProductLoaded({
    required super.products,
    required super.productsTec,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final Failure failure;
  const ProductError({
    required super.products,
    required super.productsTec,
    required super.metaData,
    required super.params,
    required this.failure,
  });
  @override
  List<Object> get props => [];
}
