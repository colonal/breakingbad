import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import '../widgets/character_itme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    CharactersCubit.get(context).getAllCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching
            ? const BackButton(color: MyColors.myGrey)
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoIntarnetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }

  buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (contex, state) {
      if (state is CharactersLoadedState) {
        allCharacters = (state).characters;

        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, int index) {
          debugPrint("index: $index");
          return CharacterItnme(
              character: _searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : searchedForCharacters[index]);
        });
  }

  showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(color: MyColors.myYellow));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: "Find a character ...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacters) =>
          addSearchedForItmsToSearchedList(searchedCharacters),
    );
  }

  addSearchedForItmsToSearchedList(String searchedCharacters) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSerch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSerch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSerch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoIntarnetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Can't connect .. check internet",
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Image.asset("assets/images/no_internet.png"),
          ],
        ),
      ),
    );
  }
}
