import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/components/appBar/app_bar.dart';
import 'package:pokedex/features/details/container/details_container.dart';
import 'package:pokedex/features/home/pages/components/pokemon_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.list,
    required this.onItemTap,
  }) : super(key: key);

  final List<Pokemon> list;
  final Function(String, DetailsArguments) onItemTap;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> displayedList = [];

  int _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    displayedList = widget.list;
  }

  List<Pokemon> _search(String? value) {
    value = value!.trim().toLowerCase();
    final result = widget.list.where((pokemon) {
      final formattedNumber = pokemon.number.toString().padLeft(3, '0');
      return formattedNumber.contains(value!) ||
          pokemon.name.toLowerCase().contains(value);
    }).toList();
    return result;
  }

  List<Pokemon> onSort(int? value) {
    List<Pokemon> result = widget.list;
    _selectedValue == 1
        ? result.sort((a, b) => a.number.compareTo(b.number))
        : result.sort((a, b) => a.name.compareTo(b.name));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pokédex',
        image: const AssetImage('lib/assets/pokeball.png'),
        selectedValue: _selectedValue,
        onSearch: (value) {
          setState(() {
            displayedList = _search(value);
          });
        },
        onSort: (value) {
          setState(() {
            _selectedValue = value;
            displayedList = onSort(value);
          });
        },
      ),
      body: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 24),
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: displayedList
            .map((e) => PokemonItem(
                  pokemon: e,
                  onTap: widget.onItemTap,
                  index: displayedList.indexOf(e),
                ))
            .toList(),
      ),
    );
  }
}
