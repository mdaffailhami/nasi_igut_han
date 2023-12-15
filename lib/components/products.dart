import 'package:flutter/material.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/rupiah.dart';
import 'package:nasi_igut_han/widgets/product_card.dart';

class MyProducts extends StatelessWidget {
  const MyProducts({super.key});

  static final GlobalKey componentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Produk Kami', style: Theme.of(context).textTheme.headlineMedium),
        const Divider(),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: [
            MyProductCard(
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
