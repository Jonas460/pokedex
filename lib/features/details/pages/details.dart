import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/details/components/detail_app_bar.dart';
import 'package:pokedex/features/details/components/detail_list.dart';
import 'package:pokedex/features/details/components/pokemon_base_status.dart';
import 'package:pokedex/features/details/components/pokemon_details_info.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.pokemon,
    required this.list,
    required this.onBack,
    required this.controller,
    required this.onChangePokemon,
  }) : super(key: key);

  final Pokemon pokemon;
  final List<Pokemon> list;
  final VoidCallback onBack;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  bool isOnTop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          setState(() {
            if (scrollController.position.pixels > 37) {
              isOnTop = false;
            } else if (scrollController.position.pixels <= 36) {
              isOnTop = true;
            }
          });
          return false;
        },
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            DetailAppBar(
              pokemon: widget.pokemon,
              onBack: widget.onBack,
              isOnTop: isOnTop,
            ),
            DetailList(
              pokemon: widget.pokemon,
              list: widget.list,
              controller: widget.controller,
              onChangePokemon: widget.onChangePokemon,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: widget.pokemon.baseColor,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.pokemon.types!.map((type) {
                                return Chip(
                                  label: Text(
                                    type,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: widget.pokemon.baseColor,
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sobre',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.pokemon.baseColor),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PokemonDetailsInfo(
                                label: 'Peso:',
                                value: widget.pokemon.weight.toString(),
                              ),
                              const Divider(
                                color: Colors.black,
                                height: 20,
                                thickness: 1,
                              ),
                              PokemonDetailsInfo(
                                label: 'Altura:',
                                value: widget.pokemon.height.toString(),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          const Text(
                            'Habilidades:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: widget.pokemon.abilities!.map((ability) {
                              return Text(
                                ability,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          PokemonDetails(
                            pokemon: widget.pokemon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
