// Importing necessary packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task.dart';

// Singleton class to handle database operations
class DatabaseHelper {
  static final DatabaseHelper _instance =
      DatabaseHelper._internal(); // Singleton instance
  factory DatabaseHelper() => _instance; // Factory constructor
  static Database? _database; // Database instance

  DatabaseHelper._internal(); // Private constructor

  // Getter to retrieve the database instance, initializing it if necessary
  Future<Database> get database async {
    if (_database != null)
      return _database!; // Return the existing database if already initialized
    _database =
        await _initDatabase(); // Initialize the database if not already done
    return _database!;
  }

  // Method to initialize the database
  Future<Database> _initDatabase() async {
    String path = join(
        await getDatabasesPath(), 'todo_database.db'); // Get the database path
    return await openDatabase(
      path,
      version: 1, // Set the database version
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, notes TEXT, dueDate TEXT, notify INTEGER, color INTEGER, finished INTEGER)", // SQL query to create the tasks table
        );
      },
    );
  }

  // Method to insert a task into the database
  Future<void> insertTask(Task task) async {
    final db = await database; // Get the database instance
    await db.insert(
      'tasks', // Table name
      task.toMap(), // Convert the task to a map
      conflictAlgorithm: ConflictAlgorithm
          .replace, // Replace the existing task if a conflict occurs
    );
  }

  // Method to retrieve all tasks from the database
  Future<List<Task>> tasks() async {
    final db = await database; // Get the database instance
    final List<Map<String, dynamic>> maps =
        await db.query('tasks'); // Query the tasks table
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]); // Convert each map to a Task object
    });
  }

  // Method to update a task in the database
  Future<void> updateTask(Task task) async {
    final db = await database; // Get the database instance
    await db.update(
      'tasks', // Table name
      task.toMap(), // Convert the task to a map
      where: 'id = ?', // Where clause to specify which task to update
      whereArgs: [task.id], // Arguments for the where clause
    );
  }

  // Method to delete a task from the database
  Future<void> deleteTask(int id) async {
    final db = await database; // Get the database instance
    await db.delete(
      'tasks', // Table name
      where: 'id = ?', // Where clause to specify which task to delete
      whereArgs: [id], // Arguments for the where clause
    );
  }
}
