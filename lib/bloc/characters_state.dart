import 'package:ejemplo/data/models/character.dart';
import 'package:equatable/equatable.dart';

class CharactersState extends Equatable {
  final List<Character> items;
  final String search;
  final List<int>? favoriteCharacters;

  List<Character> get filteredItems => items
      .where((character) =>
          search == '' ||
          character.fullName.toLowerCase().contains(search.toLowerCase()))
      .toList();

  int get count => filteredItems.length;

  const CharactersState(
      {this.items = const [], this.search = '', this.favoriteCharacters});

  CharactersState copyWith({
    List<Character>? items,
    String? search,
    List<int>? favoriteCharacters,
  }) {
    return CharactersState(
      items: items ?? this.items,
      search: search ?? this.search,
      favoriteCharacters: favoriteCharacters ?? this.favoriteCharacters,
    );
  }

  @override
  List<Object> get props =>
      [items, search, favoriteCharacters?.join(',') ?? ''];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersFetched extends CharactersState {
  const CharactersFetched({
    required List<Character> items,
    String search = '',
    List<int>? favoriteCharacters,
  }) : super(
            items: items,
            search: search,
            favoriteCharacters: favoriteCharacters);
}

class CharactersEmpty extends CharactersState {}

class CharactersFailed extends CharactersState {}
