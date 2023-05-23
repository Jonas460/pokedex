import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/details/components/detail_item.dart';

class DetailList extends StatelessWidget {
  const DetailList({
    super.key,
    required this.pokemon,
    required this.list,
    required this.controller,
    required this.onChangePokemon,
  });

  final Pokemon pokemon;
  final List<Pokemon> list;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: pokemon.baseColor,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView(
                onPageChanged: (index) => onChangePokemon(list[index]),
                controller: controller,
                children: list.map(
                  (e) {
                    bool diff = e.name != pokemon.name;
                    return DetailItemList(
                      isDiff: diff,
                      pokemon: e,
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
