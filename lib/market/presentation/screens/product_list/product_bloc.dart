import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/product_model.dart';
import '../../../domain/entites/pagination_meta_data.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/error/failures.dart';
import '../../../data/models/filter_params_model.dart';
import '../../../domain/usecase/product/get_product_category_usecase.dart';
import '../../../domain/usecase/product/get_product_usecase.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase _getProductUseCase;
  final GetProductCategoryUseCase _getProductCategoryUseCase;

  ProductBloc(
      this._getProductUseCase,
      this._getProductCategoryUseCase,
      ) : super(
      ProductInitial(
          products: const [],
          productsTec: const [],
          params: const FilterProductParams(),
          metaData: PaginationMetaData(pageSize: 20, limit: 0, total: 0,))
  ) {
    on<GetProducts>(_onLoadProducts);
    on<GetMoreProducts>(_onLoadMoreProducts);
    on<SortProducts>(_onSortProducts);
  }

  void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading(
        products: const [],
        productsTec: const [],
        metaData: state.metaData,
        params: event.params,
      ));
      final result = await _getProductUseCase(event.params);
      final resultTec = await _getProductCategoryUseCase("smartphones");
      resultTec.fold(
        (failure) => emit(ProductError(
          products: state.products,
          productsTec: state.productsTec,
          metaData: state.metaData,
          failure: failure,
          params: event.params,
        )),
            (productResponse) => emit(ProductLoaded(
          // metaData: productResponse.paginationMetaData,
          metaData: PaginationMetaData(pageSize: 20, limit: 0, total: 0),
          products: state.products,
          productsTec: productResponse.products,
          params: event.params,
        )),
      );
      result.fold(
            (failure) => emit(ProductError(
          products: state.products,
          productsTec: state.productsTec,
          metaData: state.metaData,
          failure: failure,
          params: event.params,
        )),
            (productResponse) => emit(ProductLoaded(
          // metaData: productResponse.paginationMetaData,
          metaData: PaginationMetaData(pageSize: 20, limit: 0, total: 0),
          products:productResponse.products,
          productsTec: state.productsTec,
          params: event.params,
        )),
      );
    } catch (e,s) {
      print("Error--> ${e} - ${s}");
      emit(ProductError(
        products: state.products,
        productsTec: state.productsTec,
        metaData: state.metaData,
        failure: ExceptionFailure(),
        params: event.params,
      ));
    }
  }

  void _onSortProducts(SortProducts event, Emitter<ProductState> emit) {
    // Use the sort order from the event to trigger sorting
    if (event.sortOrder != null) {
      // state.products.sort((a, b) {
      //   switch (event.sortOrder!) {
      //     case SortOrder.newest:
      //       return b.createdAt.compareTo(a.createdAt);
      //     case SortOrder.highToLow:
      //       return b.priceTags.first.price.compareTo(a.priceTags.first.price);
      //     case SortOrder.lowToHigh:
      //       return a.priceTags.first.price.compareTo(b.priceTags.first.price);
      //     case SortOrder.aToZ:
      //       return a.name.compareTo(b.name);
      //     case SortOrder.zToA:
      //       return b.name.compareTo(a.name);
      //   }
      // });
    } else {
      // If SortOrder is null, consider it as a request for unsorted products
      // You can optionally log a message or handle it in a specific way
      // For now, let's keep the products in their current order
    }

    emit(ProductLoaded(
      metaData: state.metaData,
      products: state.products,
      productsTec: state.productsTec,
      params: state.params,
    ));
  }

  void _onLoadMoreProducts(
      GetMoreProducts event, Emitter<ProductState> emit) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedProductsLength = state.products.length;
    // check state and loaded products amount[loadedProductsLength] compare with
    // number of results total[total] results available in server
    if (state is ProductLoaded && (loadedProductsLength < total)) {
      try {
        emit(ProductLoading(
          products: state.products,
          productsTec: state.productsTec,
          metaData: state.metaData,
          params: state.params,
        ));
        final result =
            await _getProductUseCase(FilterProductParams(limit: limit + 30));
        result.fold(
          (failure) => emit(ProductError(
            products: state.products,
            productsTec: state.productsTec,
            metaData: state.metaData,
            failure: failure,
            params: state.params,
          )),
          (productResponse) {
            List<ProductModel> products = state.products;
            List<ProductModel> productsTec = state.productsTec;
            products.addAll(productResponse.products);
            emit(ProductLoaded(
              metaData: state.metaData,
              products: products,
              productsTec: productsTec,
              params: state.params,
            ));
          },
        );
      } catch (e,s) {
        print("Error--> ${e} - ${s}");
        emit(ProductError(
          products: state.products,
          productsTec: state.productsTec,
          metaData: state.metaData,
          failure: ExceptionFailure(),
          params: state.params,
        ));
      }
    }
  }
}

//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final GetProductUseCase _getProductUseCase;
//
//   ProductBloc(this._getProductUseCase)
//       : super(const ProductInitial(
//     products: [],
//     params: FilterProductParams(),
//   )) {
//     on<GetProducts>(_onLoadProducts);
//
//   }
//
//   void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
//     try {
//       emit(ProductLoading(
//         products: const [],
//         params: event.params,
//       ));
//       final result = await _getProductUseCase(event.params);
//       result.fold(
//             (failure) => emit(ProductError(
//           products: state.products,
//           failure: failure,
//           params: event.params,
//         )),
//             (productResponse) => emit(ProductLoaded(
//           products: productResponse.products,
//           params: event.params,
//         )),
//       );
//     } catch (e,s) {
//       print("Error--> ${e} - ${s}");
//       emit(ProductError(
//         products: state.products,
//         failure: ExceptionFailure(),
//         params: event.params,
//       ));
//     }
//   }
//
//
//
//
//
// }
