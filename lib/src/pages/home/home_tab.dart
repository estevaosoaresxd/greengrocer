import 'package:flutter/material.dart';

//APP DATA
// ignore: library_prefixes
import 'package:greengrocer/src/config/app_data.dart' as appData;

// COLORS
import 'package:greengrocer/src/config/custom_colors.dart';

// PACKAGES
import 'package:badges/badges.dart';

// COMPONENTS
import 'package:greengrocer/src/pages/home/components/category_title.dart';
import 'package:greengrocer/src/pages/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: "Green",
                style: TextStyle(color: CustomColors.customSwatchColors),
              ),
              TextSpan(
                  text: "grocer",
                  style: TextStyle(color: CustomColors.customConstrastColors)),
            ],
          ),
        ),
        actions: [
          // Cart Button
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customConstrastColors,
                badgeContent: const Text(
                  "0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColors,
                ),
              ),
            ),
          )
        ],
      ),
      // BODY
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquisa aqui...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customConstrastColors,
                  size: 21,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
            ),
          ),

          // CATEGORYS
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 25),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((_, index) {
                  return CategoryTile(
                    category: appData.categorys[index],
                    isSelected: appData.categorys[index] == selectedCategory,
                    onPressed: () {
                      setState(() {
                        selectedCategory = appData.categorys[index];
                      });
                    },
                  );
                }),
                separatorBuilder: (_, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: appData.categorys.length),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5,
              ),
              itemCount: appData.items.length,
              itemBuilder: (_, index) {
                return ItemTile(
                  item: appData.items[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
