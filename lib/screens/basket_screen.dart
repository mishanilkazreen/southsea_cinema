import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() {
    return _BasketScreenState();
  }
}

class _BasketScreenState extends State<BasketScreen> {
  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          'The basket is empty',
          style: TextStyle(fontSize: 16, color: cinemaFontMuted),
        ),
      ),
    );
  }

  TableRow _buildLineItem(BasketRepository basket, BasketItem item, int index) {
    return TableRow(
      children: [
        Text(
          '${item.quantity} tickets',
          style: const TextStyle(color: cinemaFontWhite),
        ),
        Text(
          '${item.movie.name}\n'
          '${item.movie.screenings.join('\n')}\n'
          'Southsea Cinema Room',
          style: const TextStyle(color: cinemaFontWhite),
        ),
        Text(
          '£${(item.lineTotal / 100).toStringAsFixed(2)}',
          style: const TextStyle(color: cinemaFontWhite),
          textAlign: TextAlign.right,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: cinemaBrandDark,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            icon: const Icon(Icons.delete_outline, color: cinemaFontWhite),
            onPressed: () {
              setState(() {
                basket.removeItem(index);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value, {bool bold = false}) {
    final TextStyle style;
    if (bold) {
      style = const TextStyle(
        color: cinemaFontWhite,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
    } else {
      style = const TextStyle(color: cinemaFontWhite);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _buildBasketList(BasketRepository basket, List<BasketItem> items) {
    const TextStyle headerStyle = TextStyle(
      color: cinemaFontWhite,
      fontWeight: FontWeight.bold,
    );

    final List<TableRow> rows = [];
    rows.add(
      const TableRow(
        children: [
          Text('Item', style: headerStyle),
          Text('Details', style: headerStyle),
          Text('Price', style: headerStyle, textAlign: TextAlign.right),
          SizedBox(),
        ],
      ),
    );

    for (int index = 0; index < items.length; index++) {
      final BasketItem item = items[index];
      rows.add(_buildLineItem(basket, item, index));
    }

    final List<Widget> children = [];

    children.add(const Text('MY ORDER', style: cinemaSectionTitleStyle));
    children.add(const SizedBox(height: 16));
    children.add(
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: rows,
      ),
    );

    children.add(const SizedBox(height: 24));
    children.add(
      _buildTotalRow(
        'Service Charge',
        '£${(basket.getServiceCharge() / 100).toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Total Due',
        '£${(basket.getTotalDue() / 100).toStringAsFixed(2)}',
        bold: true,
      ),
    );
    children.add(const SizedBox(height: 24));

    children.add(
      SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          label: 'BUY TICKETS',
          onPressed: () {
            setState(() {
              basket.clear();
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Your tickets have been purchased.')));
          },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketRepository basket = BasketRepository.instance;
    final List<BasketItem> items = basket.getItems();

    final Widget content;
    if (items.isEmpty) {
      content = _buildEmptyState();
    } else {
      content = _buildBasketList(basket, items);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
