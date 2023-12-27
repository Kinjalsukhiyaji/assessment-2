import 'package:e_learning_application/model/category.dart';
import 'package:e_learning_application/model/question.dart';
import 'package:e_learning_application/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBHelper{
  static final String _dbName = 'user.db';
  static int _dbVersion = 1;
  static final String _tableUser = 'users';
  static final String _id = 'id';
  static final String _fname = 'fname';
  static final String _lname = 'lname';
  static final String _email = 'email';
  static final String _pass = 'password';

  static final String _CategoryTable = 'Category';
  static final String _cid = 'id';
  static final String categoryType = 'CategoryName';

  static final String _questionTable = 'Questions';
  static final String _qid = 'Qid';
  static final String _question = 'Question';
  static final String _option = 'Option';
  static final String _Ans = 'Answer';
  static final String _CategorysId = 'Cids';

  static Database? _database;
  Future<Database?> getDatabase() async {
    if (_database == null) {
      _database = await createDatabase();
    }
    return _database;
  }
  Future<Database> createDatabase() async {

    var path = join(await getDatabasesPath(), _dbName);
    print('database path : $path');
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $_tableUser ('
            '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$_fname TEXT, '
            '$_lname TEXT, '
            '$_email TEXT, '
            '$_pass TEXT'
            ')');

        await db.execute('CREATE TABLE $_CategoryTable ('
            '$_cid INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$categoryType TEXT'
            ')');

        await db.execute('''
    CREATE TABLE $_questionTable (
      $_qid INTEGER PRIMARY KEY AUTOINCREMENT,
      $_question TEXT,
      $_option TEXT,
      $_CategorysId INTEGER,
      $_Ans TEXT,
      FOREIGN KEY ($_CategorysId) REFERENCES $_CategoryTable($_cid) ON DELETE CASCADE
    )
''');
      },
    );
  }

  Future<int> insert(User user) async {
    final db = await getDatabase();
    return await db!.insert(_tableUser, user.toMap());
  }

  Future<bool> isLoginUser(String email,String pass) async {
    final db = await getDatabase();
    List<Map<String,dynamic>> result = await db!.query('$_tableUser',where: '$_email = ? AND $_pass = ?', whereArgs: [email,pass]);
    return result.isNotEmpty;
  }

  Future<int> addcategory(Category category) async {
    final db = await getDatabase();
    return await db!.insert(_CategoryTable,category.toMap());
  }

  Future<List<Category>> getCategoryList() async {
    var categoryList = <Category>[];
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db!.rawQuery('SELECT * FROM $_CategoryTable');
    print(maps);
    if (maps.isNotEmpty) {
      categoryList = maps.map((map) => Category.fromJson(map)).toList();
    }
    return categoryList;
  }

  Future<int> deleteCategory(int id) async {
    final db = await getDatabase();
    return await db!.delete(_CategoryTable, where: 'id = ?', whereArgs: [id]);
  }
  Future<int> updateCategory (Category category) async {
    final db = await getDatabase();
    return await db!.update(_CategoryTable, category.toMap(),where: '$_id = ?',whereArgs: [category.id]);
  }

  Future<List<Category>> read_category() async {
    var categoryList = <Category>[];
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps =
    await db!.rawQuery('SELECT * FROM $_CategoryTable');
    print(maps);
    if (maps.isNotEmpty) {
      categoryList = maps.map((map) => Category.fromJson(map)).toList();
    }
    return categoryList;
  }
  Future<int> insert_question(Question question) async {
    final db = await getDatabase();
    return await db!.insert(_questionTable, question.toJson());
  }
  Future<List<Question>> readQuestionsBaseOnCategory(int id) async {
    final db = await getDatabase();
    print(id);
    List<Map<String, dynamic>> results = await db!.query(_questionTable, where: 'Cids = ?', whereArgs: [id]);
    List<Question> questions = [];
    for (var result in results) {
      questions.add(Question.fromJson(result));
    }
    return questions;
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> results = await db!.query(_questionTable);
    List<Question> questions = [];
    for (var result in results) {
      questions.add(Question.fromJson(result));
    }
    return questions;
  }
}