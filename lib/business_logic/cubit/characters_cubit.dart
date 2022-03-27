import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepositort charactersRepositort;
  CharactersCubit(this.charactersRepositort) : super(CharactersInitial());
  List<Character> characters = [];

  static CharactersCubit get(context) => BlocProvider.of(context);

  List<Character> getAllCharacter() {
    charactersRepositort.getAllCharacter().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters = characters;
    });

    return characters;
  }

  void getQuotes(String chareName) {
    charactersRepositort.getCharacterQuote(chareName).then((quotes) {
      emit(QuotesLoadedState(quotes));
    });
  }
}
