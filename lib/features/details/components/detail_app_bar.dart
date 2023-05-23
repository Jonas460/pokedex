import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:recase/recase.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    super.key,
    required this.pokemon,
    required this.onBack,
    required this.isOnTop,
  });

  final Pokemon pokemon;
  final VoidCallback onBack;
  final bool isOnTop;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: pokemon.baseColor,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(Icons.chevron_left),
      ),
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ReCase(pokemon.name).titleCase,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '#${pokemon.number.toString().padLeft(3, '0')}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
