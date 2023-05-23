import 'package:flutter/material.dart';
import 'package:pokedex/common/error_exception/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/components/error/po_error.dart';
import 'package:pokedex/components/loading/po_loading.dart';
import 'package:pokedex/features/details/container/details_container.dart';
import 'package:pokedex/features/home/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.repository,
    required this.onItemTap,
  }) : super(key: key);

  final IPokemonRepository repository;
  final Function(String, DetailsArguments) onItemTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: repository.getAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PoLoading();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return HomePage(
              list: snapshot.data!,
              onItemTap: onItemTap,
            );
          }

          if (snapshot.hasError) {
            return PoError(error: (snapshot.error as Failure).message!);
          }

          return Container();
        });
  }
}
