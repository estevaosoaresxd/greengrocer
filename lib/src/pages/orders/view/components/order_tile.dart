import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/controller/order_controller.dart';
import 'package:greengrocer/src/pages/orders/view/components/order_status_widget.dart';
import 'package:greengrocer/src/pages/widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
          init: OrderController(order),
          global: false,
          builder: (controller) => ExpansionTile(
            onExpansionChanged: (value) {
              if (value && order.items.isEmpty) {
                controller.getOrderItems();
              }
            },
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pedido: ${order.id}",
                ),
                Text(
                  utilsServices.formatDateTime(order.createdDateTime!),
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            children: controller.isLoading
                ? [
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  ]
                : [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          // LIST PRODUCTS
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 150,
                              child: ListView(
                                children: order.items.map((orderItem) {
                                  return _OrderItemWidget(
                                    utilsServices: utilsServices,
                                    orderItem: orderItem,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          // DIVIDER
                          VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                            width: 8,
                          ),

                          Expanded(
                            child: OrderStatusWidget(
                              status: order.status,
                              isOverdue: order.overdueDateTime
                                  .isBefore(DateTime.now()),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // STATUS

                    // TOTAL
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(fontSize: 20),
                        children: [
                          const TextSpan(
                            text: 'Total: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: utilsServices.priceToCurrency(order.total),
                          )
                        ],
                      ),
                    ),

                    // BUTTON PAYMENT
                    Visibility(
                      visible:
                          order.status == 'pending_payment' && !order.isOverdue,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => PaymentDialog(
                              order: order,
                            ),
                          );
                        },
                        icon: Image.asset('assets/images/pix.png', width: 20),
                        label: const Text('Ver QR Code Pix'),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            "${orderItem.quantity} ${orderItem.item.unit} ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.title)),
          Text(
            utilsServices.priceToCurrency(orderItem.totalPrice()),
          )
        ],
      ),
    );
  }
}
