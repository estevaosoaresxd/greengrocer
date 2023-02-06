import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CardTile extends StatefulWidget {
  final CartItemModel cartItems;

  const CardTile({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // IMAGE
        leading: Image.network(
          widget.cartItems.item.picture,
          height: 60,
          width: 60,
        ),

        // ITEM NAME
        title: Text(
          widget.cartItems.item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        // PRICE
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItems.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColors,
            fontWeight: FontWeight.bold,
          ),
        ),

        // QUANTITY
        trailing: QuantityWidget(
          isRemovable: true,
          value: widget.cartItems.quantity,
          suffixText: widget.cartItems.item.unit,
          result: (quantity) async {
            await controller.changeItemQuantity(
              item: widget.cartItems,
              quantity: quantity,
            );
          },
        ),
      ),
    );
  }
}
