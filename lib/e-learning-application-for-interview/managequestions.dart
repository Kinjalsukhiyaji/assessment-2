import 'package:flutter/material.dart';

import '../DB_HElper/dbhelper.dart';
import '../model/question.dart';


class questions extends StatefulWidget {
  int id;
  String name;

  questions(this.id,this.name);

  @override
  State<questions> createState() => _questionsState(id,name);
}

class _questionsState extends State<questions> {

  List<Question> questions = [];

  int? id;
  String name;
  List<String> alphabet = ["A","B","C","D"];
  _questionsState(this.id,this.name);

  DBHelper helper = DBHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${name}"),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) {
          return Container(
            height: 20,
          );
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: questions.length, // Display only the first question
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display Question
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${index+1}",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),)
                      ],
                    ),
                    Text(
                      questions[index].question,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: questions[index].option.asMap().entries.map((entry) {
                        int optionIndex = entry.key;
                        String option = entry.value;

                        String letter = String.fromCharCode('A'.codeUnitAt(0) + optionIndex); // Convert index to letter A, B, C, D...

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '$letter. $option', // Display as A. OptionText, B. OptionText, etc.
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Answer:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          questions[index].Answer,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> loadData(int? id) async {
    var ids = id;
    var list = await helper.readQuestionsBaseOnCategory(ids!);
    setState(() {
      questions.addAll(list);
    });
  }
}
