class ApiConsts {
  static String getAllPokemonsURL(int limit) {
    return 'https://pokeapi.co/api/v2/pokemon?limit=$limit';
  }

  static String getAllPokemonsImage(int number) {
    return 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${number.toString().padLeft(3, '0')}.png';
  }
}
