import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/details/container/details_container.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    Key? key,
    required this.pokemon,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  final Pokemon pokemon;
  final Function(String, DetailsArguments) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => onTap(
            '/details',
            DetailsArguments(
              pokemon: pokemon,
              index: index,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('#${pokemon.number.toString().padLeft(3, '0')}'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(239, 239, 239, 1),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(0, 50),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.contain,
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(pokemon.name),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
