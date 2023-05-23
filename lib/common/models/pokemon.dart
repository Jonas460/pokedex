import 'package:flutter/material.dart';
import 'package:pokedex/common/consts/api_consts.dart';

class Pokemon {
  final String name;
  final int number;
  final String? url;
  //final String? imageUrl;
  final String? habitat;
  final List<String>? types;
  final double? height;
  final double? weight;
  final List<String>? abilities;
  final Map<String, int>? baseStats;

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    final abilities = json['abilities'] as List<dynamic>;
    final types = json['types'] as List<dynamic>;

    final abilitiesList = abilities
        .map<String>((ability) => ability['ability']['name'])
        .toList()
        .cast<String>();
    final typesList = types
        .map<String>((type) => type['type']['name'])
        .toList()
        .cast<String>();

    return Pokemon(
      name: json['name'],
      number: json['id'],
      //imageUrl: json['sprites']['front_default'],
      abilities: abilitiesList,
      types: typesList,
      height: json['height'] / 10,
      weight: json['weight'] / 10,
      baseStats: {
        'HP': json['stats'][0]['base_stat'],
        'Atk': json['stats'][1]['base_stat'],
        'Def': json['stats'][2]['base_stat'],
        'SAtk': json['stats'][3]['base_stat'],
        'SDef': json['stats'][4]['base_stat'],
        'SPD': json['stats'][5]['base_stat'],
      },
    );
  }
  String get imageUrl => ApiConsts.getAllPokemonsImage(number);
  Color? get baseColor => _color(type: types![0]);

  Pokemon({
    required this.name,
    required this.number,
    this.url,
    //this.imageUrl,
    this.habitat,
    this.types,
    this.height,
    this.weight,
    this.abilities,
    this.baseStats,
  });

  static Color? _color({required String type}) {
    switch (type) {
      case 'normal':
        return Colors.brown[400];
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'ice':
        return Colors.cyanAccent[400];
      case 'fighting':
        return Colors.orange;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.orange[300];
      case 'flying':
        return Colors.indigo[200];
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen[500];
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.indigo[400];
      case 'dark':
        return Colors.brown;
      case 'dragon':
        return Colors.indigo[800];
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
