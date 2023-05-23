import 'package:flutter/material.dart';
import 'package:pokedex/common/error_exception/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/components/error/po_error.dart';
import 'package:pokedex/components/loading/po_loading.dart';
import 'package:pokedex/features/details/pages/details.dart';

class DetailsArguments {
  DetailsArguments({this.index, required this.pokemon});
  final Pokemon pokemon;
  final int? index;
}

class DetailsContainer extends StatefulWidget {
  const DetailsContainer({
    Key? key,
    required this.repository,
    required this.arguments,
    required this.onBack,
  }) : super(key: key);

  final IPokemonRepository repository;
  final DetailsArguments arguments;
  final VoidCallback onBack;

  @override
  State<DetailsContainer> createState() => _DetailsContainerState();
}

class _DetailsContainerState extends State<DetailsContainer> {
  late PageController controller;
  late Future<List<Pokemon>> _future;
  Pokemon? _pokemon;

  @override
  void initState() {
    controller = PageController(
        viewportFraction: 0.5, initialPage: widget.arguments.index!);
    _future = widget.repository.getAllPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PoLoading();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            _pokemon ??= widget.arguments.pokemon;
            return Details(
              pokemon: _pokemon!,
              list: snapshot.data!,
              onBack: widget.onBack,
              controller: controller,
              onChangePokemon: (Pokemon value) {
                setState(() {
                  _pokemon = value;
                });
              },
            );
          }

          if (snapshot.hasError) {
            return PoError(error: (snapshot.error as Failure).message!);
          }

          return Container();
        });
  }
}
