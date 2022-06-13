import 'package:ejemplo/data/characters_persistence.dart';
import 'package:ejemplo/data/models/character.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharacterPersistenceSqlite implements CharacterPersistence {
  Future<Database>? database;

  CharacterPersistenceSqlite() {
    _init();
  }

  void _init() async {
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'charactes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE favourite_characters(id INTEGER PRIMARY KEY)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  @override
  Future<List<int>> getFavouriteCharacters() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, Object?>>? maps =
        await db?.query('favourite_characters');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps?.length ?? 0, (i) {
      if (maps != null) {
        return maps[i]['id'] as int;
      } else {
        return -1;
      }
    });
  }

  // Define a function that inserts dogs into the database
  Future<void> insertFavouriteCharacter(int characterId) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db?.insert(
      'favourite_characters',
      {'id': characterId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavouriteCharacter(int characterId) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db?.delete(
      'favourite_characters',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [characterId],
    );
  }

  @override
  void setFavouriteCharacters(List<int> favouriteChractersIDs) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db?.delete(
      'favourite_characters',
      // Use a `where` clause to delete a specific dog.
      where: 'id not in (?)',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [favouriteChractersIDs.join(',')],
    );

    List<int> currentFav = await getFavouriteCharacters();
    List<int> toInsert =
        favouriteChractersIDs.where((id) => !currentFav.contains(id)).toList();

    for (int id in toInsert) {
      await insertFavouriteCharacter(id);
    }
  }
}
