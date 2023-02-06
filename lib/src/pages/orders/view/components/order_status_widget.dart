import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  final Map<String, int> allState = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currenctStatus => allState[status]!;

  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(
          isActive: true,
          title: "Pedido Confirmado",
        ),
        const _CustomDivider(),
        if (currenctStatus == 1) ...[
          const _StatusDot(
            isActive: true,
            title: "Pix estornado",
            backgroundColor: Colors.orange,
          ),
        ] // NEW LIST

        else if (isOverdue) ...[
          const _StatusDot(
            isActive: true,
            title: "Pagamento Pix Vencido",
            backgroundColor: Colors.red,
          ),
        ] else ...[
          _StatusDot(isActive: currenctStatus >= 2, title: 'Pagamento'),
          const _CustomDivider(),
          _StatusDot(isActive: currenctStatus >= 3, title: 'Preparando'),
          const _CustomDivider(),
          _StatusDot(isActive: currenctStatus >= 4, title: 'Envio'),
          const _CustomDivider(),
          _StatusDot(isActive: currenctStatus >= 5, title: 'Entregue'),
        ]
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot({
    required this.isActive,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // DOT
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CustomColors.customSwatchColors),
              color: isActive
                  ? backgroundColor ?? CustomColors.customSwatchColors
                  : Colors.transparent),
          child: isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(
          width: 5,
        ),

        // Text
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
