import 'package:ejemplo/bloc/characters_state.dart';
import 'package:ejemplo/bloc/charactes_cubit.dart';
import 'package:ejemplo/data/characters_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CharactersCubit(CharacterService()),
        child: Scaffold(
          appBar: AppBar(
              // The search area here
              title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: BlocBuilder<CharactersCubit, CharactersState>(
                  builder: (context, charactersState) {
                final characterCubit = context.read<CharactersCubit>();

                return TextField(
                  onChanged: (value) => characterCubit.search(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: InputBorder.none),
                );
              }),
            ),
          )),
          body: BlocBuilder<CharactersCubit, CharactersState>(
              builder: (context, state) {
            if (state is CharactersFailed) {
              return const Text('Failed to fetch characters');
            }

            if (state is CharactersEmpty) {
              return const Text('No characters');
            }

            if (state is CharactersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: state.count,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.filteredItems[index].imageUrl),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: 250,
                        child: Column(
                          children: [
                            Text(state.filteredItems[index].fullName),
                            Text(state.filteredItems[index].title,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ));
  }
}
