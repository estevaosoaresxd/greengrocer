import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

ItemModel apple = ItemModel(
  id: '1',
  category: CategoryModel(title: 'Frutas', id: '1', items: [], pagination: 0),
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  picture: 'assets/fruits/apple.png',
  title: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  id: '2',
  picture: 'assets/fruits/grape.png',
  category: CategoryModel(title: 'Frutas', id: '2', items: [], pagination: 0),
  title: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  id: '3',
  category: CategoryModel(title: 'Frutas', id: '13', items: [], pagination: 0),
  picture: 'assets/fruits/guava.png',
  title: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  id: '4',
  picture: 'assets/fruits/kiwi.png',
  category: CategoryModel(title: 'Frutas', id: '4', items: [], pagination: 0),
  title: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  id: '5',
  category: CategoryModel(title: 'Frutas', id: '5', items: [], pagination: 0),
  picture: 'assets/fruits/mango.png',
  title: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  id: '6',
  category: CategoryModel(title: 'Frutas', id: '6', items: [], pagination: 0),
  picture: 'assets/fruits/papaya.png',
  title: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// List of Products
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categorys = ['Frutas', 'Grãos', 'Verduras', 'Temperos', 'Cereais'];

List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 1),
  CartItemModel(item: papaya, quantity: 3),
  CartItemModel(item: kiwi, quantity: 1)
];

UserModel user = UserModel(
  cpf: '',
  email: '',
  fullname: '',
  password: '',
  phone: '',
  id: '',
  token: '',
);

List<OrderModel> orders = [
  // Pedido 01
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2023-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:00:10.458',
    ),
    id: 'asd6a54da6s2d1',
    status: 'pending_payment',
    total: 11.0,
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: mango,
        quantity: 2,
      ),
    ],
  ),

  // Pedido 02
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2023-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),
];
