import 'dart:convert';

import 'package:ejemplo/bloc/characters_state.dart';
import 'package:ejemplo/data/characters_service.dart';
import 'package:ejemplo/data/models/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharactersCubit extends Cubit<CharactersState> {
  static const favoriteCharactersKey = 'favoriteCharacters';

  final CharacterService _service;
  SharedPreferences? _prefs;

  CharactersCubit(this._service) : super(CharactersInitial()) {
    _init();
  }

  Future<void> _init() async {
    emit(CharactersLoading());

    _prefs = await SharedPreferences.getInstance();

    try {
      final items = await _service.getAll();

      if (items.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersFetched(
            items: items, favoriteCharacters: getFavsFromStorage()));
      }
    } catch (e) {
      emit(CharactersFailed());
    }
  }

  List<int> getFavsFromStorage() {
    String? favsString = _prefs?.getString(favoriteCharactersKey);
    if (favsString == null) {
      return [];
    } else {
      return json.decode(favsString).cast<int>();
    }
  }

  void setFavsToStorage(List<int> favs) {
    _prefs?.setString(favoriteCharactersKey, json.encode(favs));
  }

  void search(String value) {
    emit(state.copyWith(search: value));
  }

  void toggleFav(Character character) {
    List<int> newFavs = state.favoriteCharacters?.toList() ?? [];

    if (newFavs.contains(character.id)) {
      newFavs.remove(character.id);
    } else {
      newFavs.add(character.id);
    }
    setFavsToStorage(newFavs);
    emit(state.copyWith(favoriteCharacters: newFavs));
  }

  bool isFavourite(Character character) {
    return state.favoriteCharacters?.contains(character.id) ?? false;
  }
}
