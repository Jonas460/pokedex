import 'package:dio/dio.dart';
import 'package:pokedex/common/consts/api_consts.dart';
import 'package:pokedex/common/error_exception/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> getAllPokemons();
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;
  PokemonRepository({required this.dio});

  @override
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await Dio().get(ApiConsts.getAllPokemonsURL(20));
      final json = response.data as Map<String, dynamic>;
      final results = json['results'] as List<dynamic>;

      List<Pokemon> allPokemons = [];

      for (final result in results) {
        final pokemonResponse = await Dio().get(result['url']);
        final pokemonJson = pokemonResponse.data as Map<String, dynamic>;
        final pokemon = Pokemon.fromMap(pokemonJson);
        allPokemons.add(pokemon);
      }

      return allPokemons;
    } catch (e) {
      throw Failure(message: 'Não foi possível carregar os dados!');
    }
  }
}
