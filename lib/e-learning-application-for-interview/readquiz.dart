import 'package:e_learning_application/DB_HElper/dbhelper.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';
import 'managequestions.dart';

class ReadQuiz extends StatefulWidget {
   ReadQuiz({super.key});

  @override
  State<ReadQuiz> createState() => _ReadQuizState();
}

class _ReadQuizState extends State<ReadQuiz> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    var tempList = await dBhelper.read_category();
    setState(() {
      categoryList.addAll(tempList);
    });
  }
  List<Category> categoryList = [];
  DBHelper dBhelper = DBHelper();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read quiz'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: categoryList.map((item) {
            return InkWell(
              onTap: () {
                print(item.id);
                Navigator.push(context, MaterialPageRoute(builder: (context) => questions(item.id!,item.CategoryName!)));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.purple,
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Text(
                      item.CategoryName!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

            );
          }).toList(),
        ),
      ),
    );
  }
}