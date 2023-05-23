import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetails({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Base Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: pokemon.baseColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (pokemon.baseStats != null)
            Column(
              children: pokemon.baseStats!.entries.map((stat) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            stat.key,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: pokemon.baseColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: Text(
                            stat.value.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 6,
                          child: LinearProgressIndicator(
                            value: stat.value / 100,
                            color: pokemon.baseColor,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
