import 'dart:collection';

import '../models/quotes.dart';

import '../web_services/character_web_services.dart';
import '../models/characters.dart';

class CharactersRepositort {
  CharacterWebServices characterWebServices;
  CharactersRepositort(this.characterWebServices);

  Future<List<Character>> getAllCharacter() async {
    final List characters = await characterWebServices.getAllCharacter();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quoste>> getCharacterQuote(String chareName) async {
    final List quotes = await characterWebServices.getCharacterQuote(chareName);
    return quotes.map((charQuotes) => Quoste.fromJason(charQuotes)).toList();
  }
}
