// ignore_for_file: no_duplicate_case_values

import 'package:bloc_exampal/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_exampal/data/models/characters.dart';
import 'package:bloc_exampal/data/repository/characters_repository.dart';
import 'package:bloc_exampal/data/web_services/character_web_services.dart';
import 'package:bloc_exampal/presentation/screen/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';
import 'presentation/screen/characters_screen.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharactersRepositort charactersRepositort;

  AppRouter() {
    charactersRepositort = CharactersRepositort(CharacterWebServices());
    charactersCubit = CharactersCubit(charactersRepositort);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(charactersRepositort),
            child: CharactersDetails(character: character),
          ),
        );
    }
  }
}
