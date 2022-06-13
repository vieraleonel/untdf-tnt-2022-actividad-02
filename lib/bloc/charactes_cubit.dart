import 'package:ejemplo/bloc/characters_state.dart';
import 'package:ejemplo/data/characters_persistence.dart';
import 'package:ejemplo/data/characters_service.dart';
import 'package:ejemplo/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterService _service;
  final CharacterPersistence _persistence;

  CharactersCubit(this._service, this._persistence)
      : super(CharactersInitial()) {
    _init();
  }

  Future<void> _init() async {
    emit(CharactersLoading());

    try {
      final items = await _service.getAll();

      if (items.isEmpty) {
        emit(CharactersEmpty());
      } else {
        List<int> favs = await _persistence.getFavouriteCharacters();
        emit(CharactersFetched(items: items, favoriteCharacters: favs));
      }
    } catch (e) {
      emit(CharactersFailed());
    }
  }

  void search(String value) {
    emit(state.copyWith(search: value));
  }

  void toggleFav(Character character) async {
    List<int> newFavs = state.favoriteCharacters?.toList() ?? [];

    if (newFavs.contains(character.id)) {
      newFavs.remove(character.id);
    } else {
      newFavs.add(character.id);
    }
    _persistence.setFavouriteCharacters(newFavs);
    emit(state.copyWith(favoriteCharacters: newFavs));
  }

  bool isFavourite(Character character) {
    return state.favoriteCharacters?.contains(character.id) ?? false;
  }
}
