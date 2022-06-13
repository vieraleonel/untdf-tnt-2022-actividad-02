import 'dart:convert';

import 'package:ejemplo/data/characters_persistence.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterPersistenceSharedPreferences implements CharacterPersistence {
  static const favoriteCharactersKey = 'favoriteCharacters';
  SharedPreferences? _prefs;

  CharacterPersistenceSharedPreferences() {
    _init();
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // A method that retrieves all the dogs from the dogs table.
  @override
  Future<List<int>> getFavouriteCharacters() async {
    String? favsString = _prefs?.getString(favoriteCharactersKey);
    if (favsString == null) {
      return Future.value([]);
    } else {
      return Future.value(json.decode(favsString).cast<int>());
    }
  }

  @override
  void setFavouriteCharacters(List<int> favouriteChractersIDs) {
    _prefs?.setString(
        favoriteCharactersKey, json.encode(favouriteChractersIDs));
  }
}
