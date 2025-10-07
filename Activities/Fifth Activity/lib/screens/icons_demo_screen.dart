import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconsDemoScreen extends StatefulWidget {
  const IconsDemoScreen({super.key});

  @override
  State<IconsDemoScreen> createState() => _IconsDemoScreenState();
}

class _IconsDemoScreenState extends State<IconsDemoScreen> {
  double _size = 24;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icons Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Material Icons (dynamic color and size):'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.hotel, color: _color, size: _size),
                Icon(Icons.pool, color: _color, size: _size),
                Icon(Icons.restaurant, color: _color, size: _size),
                Icon(Icons.wifi, color: _color, size: _size),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Size:'),
                Expanded(
                  child: Slider(
                    min: 16,
                    max: 64,
                    divisions: 12,
                    value: _size,
                    label: _size.toStringAsFixed(0),
                    onChanged: (v) => setState(() => _size = v),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Color:'),
                const SizedBox(width: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _colorDot(Colors.blue),
                    _colorDot(Colors.red),
                    _colorDot(Colors.green),
                    _colorDot(Colors.orange),
                    _colorDot(Colors.purple),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Custom Icons (FontAwesome + MaterialCommunity):'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Material Community (via material_design_icons_flutter)
                Icon(MdiIcons.bed, color: Colors.indigo, size: 32),
                Icon(MdiIcons.bedKingOutline, color: Colors.teal, size: 32),
                Icon(MdiIcons.foodForkDrink, color: Colors.deepOrange, size: 32),
                Icon(MdiIcons.swim, color: Colors.cyan, size: 32),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Font Awesome (non-const constructor)
                const FaIcon(FontAwesomeIcons.bed, color: Colors.brown, size: 28),
                const FaIcon(FontAwesomeIcons.bed, color: Colors.pink, size: 28),
                const FaIcon(FontAwesomeIcons.utensils, color: Colors.deepPurple, size: 28),
                const FaIcon(FontAwesomeIcons.personSwimming, color: Colors.green, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorDot(Color color) {
    final selected = _color == color;
    return GestureDetector(
      onTap: () => setState(() => _color = color),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: selected ? Colors.black : Colors.transparent,
            width: selected ? 2 : 0,
          ),
        ),
      ),
    );
  }
}
