import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetails extends StatelessWidget {
  const CharactersDetails({required this.character, Key? key})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    CharactersCubit.get(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo("Job : ", character.jobs.join(" / ")),
                      buildDivider(315),
                      characterInfo(
                          "Appeared in : ", character.categoryForTwoseries),
                      buildDivider(250),
                      characterInfo("Seasons : ",
                          character.appearanceOfSeasons.join(" / ")),
                      buildDivider(280),
                      characterInfo(
                          "Status : ", character.statusIfDeladorAlive),
                      buildDivider(300),
                      if (character.betterCallSaulAppearance.isNotEmpty)
                        characterInfo("Better Call Saul Seasons : ",
                            character.betterCallSaulAppearance.join(" / ")),
                      if (character.betterCallSaulAppearance.isNotEmpty)
                        buildDivider(150),
                      characterInfo("Actor/Actress : ", character.acotrName),
                      buildDivider(300),
                      const SizedBox(height: 20),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return checkIfQuotesAreLoaded(state);
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 500)
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: const TextStyle(color: MyColors.myWhite, fontSize: 16))
        ]));
  }

  buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoadedState) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(QuotesLoadedState state) {
    List<Quoste> quotes = (state).quoste;
    if (quotes.isNotEmpty) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(color: MyColors.myYellow));
  }
}
