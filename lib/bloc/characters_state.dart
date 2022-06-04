import 'dart:math';

import 'package:ejemplo/data/models/character.dart';
import 'package:equatable/equatable.dart';

class CharactersState extends Equatable {
  final List<Character> items;
  final String search;

  List<Character> get filteredItems {
    print(items);
    print(search);

    return items
        .where((element) =>
            search == '' ||
            element.fullName.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  int get count => filteredItems.length;

  const CharactersState({
    this.items = const [],
    this.search = '',
  });

  CharactersState copyWith({
    List<Character>? items,
    String? search,
  }) {
    return CharactersState(
      items: items ?? this.items,
      search: search ?? this.search,
    );
  }

  @override
  List<Object> get props => [items, search];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersFetched extends CharactersState {
  const CharactersFetched({
    required List<Character> items,
  }) : super(items: items);
}

class CharactersEmpty extends CharactersState {}

class CharactersFailed extends CharactersState {}

class CharactersSearched extends CharactersState {
  const CharactersSearched({
    required List<Character> items,
    required String search,
  }) : super(items: items, search: search);
}
