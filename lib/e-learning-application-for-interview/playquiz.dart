import 'package:flutter/material.dart';
import '../DB_HElper/dbhelper.dart';
import '../model/question.dart';

class PlayQuizPage extends StatefulWidget {


  @override
  State<PlayQuizPage> createState() => _PlayQuizPageState();

}

class _PlayQuizPageState extends State<PlayQuizPage> {
  final List<Question> questions = []; // Contains the questions
  int currentQuestionIndex = 0; // Tracks the current question index
  bool showResult = false; // Flag to control showing quiz result
  List<String> selectedAnswers = []; // List to store selected answers
  List<String> correctAnswers = []; // List to store correct answers
  int correctAnswerCount = 0; // Counter for correct answers
  DBHelper dbHelper = DBHelper(); // Database Helper

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }
  Future<void> loadQuestions() async {
    var lists = await dbHelper.getAllQuestions();
    setState(() {
      questions.addAll(lists);
      correctAnswers = questions.map((question) => question.Answer).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: showResult
              ? showQuizResult() // Display quiz result if showResult is true
              : questions.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : buildQuizScreen(), // Display quiz screen otherwise
        ),
      );
  }
  Widget buildQuizScreen() {
    int totalMarks = questions.length * 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Widgets for showing question number and total questions count
        // Replace with your desired UI
        Container(
          height: 130,
          decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${currentQuestionIndex}/${questions.length}",style: TextStyle(fontSize: 20),),
                  Text("Questions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${0}/${totalMarks.toString()}",style: TextStyle(fontSize: 20),),
                  Text("Total Marks",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        // Widget for showing the current question
        Container(
          padding: EdgeInsets.all(16.0), // Adjust padding as needed
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Change the color as needed
              width: 1.0, // Adjust the border width
            ),
            borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
          ),
          child: Column(
            children: [
              Text(
                "Question ${currentQuestionIndex + 1}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                questions[currentQuestionIndex].question,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Column(
                children: List<Widget>.generate(
                  questions[currentQuestionIndex].option.length,
                      (index) {
                    String option = questions[currentQuestionIndex].option[index];
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: selectedAnswers.isNotEmpty ? selectedAnswers[0] : null,
                      onChanged: (value) {
                        setState(() {
                          selectedAnswers.clear();
                          selectedAnswers.add(value!);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // Button to navigate to the next question or show result
        ElevatedButton(
          onPressed: () {
            // Check if an answer is selected before proceeding
            if (selectedAnswers.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select an answer!')),
              );
              return;
            }
            // Check the answer and increment correctAnswerCount if correct
            if (selectedAnswers[0] == questions[currentQuestionIndex].Answer) {
              correctAnswerCount++;
            }
            // Move to the next question or show result if it's the last question
            if (currentQuestionIndex < questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
              });
            } else {
              setState(() {
                showResult = true;
              });
            }
          },
          child: Text(currentQuestionIndex == questions.length - 1 ? 'Finish Quiz' : 'Next'
          ),
        ),
      ],
    );
  }

  Widget showQuizResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Quiz Completed!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Your Correct Answers: $correctAnswerCount/${questions.length}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

}
