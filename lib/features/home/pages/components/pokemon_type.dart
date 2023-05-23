import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

class PokemonType extends StatelessWidget {
  const PokemonType({
    Key? key,
    required this.typeName,
  }) : super(key: key);

  final String typeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(typeName),
    );
  }
}
