import 'package:ejemplo/bloc/characters_state.dart';
import 'package:ejemplo/data/characters_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterService _service;

  CharactersCubit(this._service) : super(CharactersInitial()) {
    _init();
  }

  Future<void> _init() async {
    emit(CharactersLoading());

    try {
      final items = await _service.getAll();

      if (items.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersFetched(items: items));
      }
    } catch (e) {
      emit(CharactersFailed());
    }
  }

  void search(String value) {
    emit(CharactersSearched(items: state.items, search: value));
  }
}
