import 'dart:async'; // Add this import statement
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class BuyPremiumController extends GetxController {

   List<ProductDetails> products = <ProductDetails>[];
   StreamSubscription<List<PurchaseDetails>>? _purchaseUpdatedSubscription; // Add ? to make it nullable

    @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _purchaseUpdatedSubscription = InAppPurchase.instance.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {
      // Handle purchase updates
    });
  }

   Future<void> fetchProducts() async {
    debugPrint("test1");
    const List<String> _kProductIds = <String>[
      'your_product_id',
    ];

    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kProductIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      // Handle any products not found
    }
    products = response.productDetails;
    update();
  }

    void purchaseProduct(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  void dispose() {
    _purchaseUpdatedSubscription?.cancel(); // Add ?. to ensure it's only canceled if it's not null
    super.dispose();
  }
}