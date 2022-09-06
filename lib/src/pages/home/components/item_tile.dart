import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/services/utils_services.dart';

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final ItemModel item;
  ItemTile({Key? key, required this.item}) : super(key: key);

  UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CARD
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductScreen(
                  item: item,
                ),
              ),
            );
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Image
                  Expanded(
                    child: Hero(
                      tag: item.imgUrl,
                      child: Image.asset(item.imgUrl),
                    ),
                  ),
                  //Name
                  Text(
                    item.itemName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  //Price
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwatchColors),
                      ),
                      Text(
                        "/${item.unit}",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        // TOP BUTTON
        Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                    color: CustomColors.customSwatchColors,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20),
                    )),
                child: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
