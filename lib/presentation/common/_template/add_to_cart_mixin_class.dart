

import 'package:flutter_bloc/flutter_bloc.dart';

mixin AddToCartMixin<E, S> on Bloc<E, S> {
  Future<void> handleAddToCart({
    required int productId,
    required int quantity,
    void Function()? errorState,
    void Function()? successState,
    bool showSuccessMessage = true,
  }) async {
    // Either<Failure, AddToCartResponse> response =
    //     await instance<AddToCartUseCase>().execute(
    //         AddToCartRequest(productId: productId, quantity: quantity));

    // response.fold((failure) {
    //   errorState?.call();
    // }, (data) {
    //   if (showSuccessMessage) {
    //     // SnackbarHelper.showMessage(
    //     //     Translation.added_to_card.tr, ErrorMessage.toast);
    //   }
    //   successState?.call();
    // });
  }
}
