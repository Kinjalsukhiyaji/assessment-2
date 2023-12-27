import 'package:flutter/material.dart';
import '../DB_HElper/dbhelper.dart';
import '../model/category.dart';
import '../model/question.dart';

class ManageQuestion extends StatefulWidget {
  const ManageQuestion({super.key});

  @override
  State<ManageQuestion> createState() => _ManageQuestionState();
}

class _ManageQuestionState extends State<ManageQuestion> {

  List<Category> categoryList = [];
  List<Widget> textFields = [];
  int counter = 1;
  List<TextEditingController> textEditingController = [];
  final _globalKey = GlobalKey<FormState>();
  DBHelper dBhelper = DBHelper();

   int categoryId = -1;
  String? question;
  String? answer;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    loadData();
    addTextField();
  }

  void addTextField({String initialValue = ''})
  {
    if(textFields.length < 4) {
      TextEditingController controller = TextEditingController();
      textEditingController.add(controller);
      setState(() {
        textFields.add(
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller,
                      validator: (value) {
                        if(value!.isEmpty || value == null) {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Option $counter',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),
                ),
                IconButton(
                    onPressed: () {
                      removeTextField(textFields.length - 1);
                    },
                    icon: Icon(Icons.remove_circle),
                ),
              ],
            ),
          ),
        );
        counter ++;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Limit Exceeded'),
              content: Text('You can only add 4 options'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                ),
              ],
            );
          }
      );
    }
  }

  void removeTextField(int index) {
    setState(() {
      textEditingController[index].clear();
      textFields.removeAt(index);
      textEditingController.removeAt(index);
      counter--;
    });
  }
  Future<void> loadData() async {
    var tempList = await dBhelper.read_category();
    setState(() {
      categoryList.addAll(tempList);
    });
  }
  Future<void> addQuestion(Question question, BuildContext context) async {
    int qid = await dBhelper.insert_question(question);
    if (qid != -1) {
      question.Qid = qid;
      print(qid);
      Navigator.pop(context, question);
    } else {
      print("getting Error while adding category");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Create Questions'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildcategoryFormFiled(),
            SizedBox(height: 20,),
                buildQuesForm(),
            /*TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter Question',
              ),
              maxLines: null,
            ),*/
                SizedBox(height: 20,),
                ...textFields,
                ElevatedButton(
                    onPressed: addTextField,
                    child: Text('Add Option'),
                ),
                SizedBox(height: 20,),
                buildAnswerForm(),
                /* TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Answer',
                  ),
                ),*/
                SizedBox(height: 20,),
               /* ElevatedButton(
                  onPressed: () {},
                  child: Text('Submit'),
                ),*/
                MaterialButton(
                  color: Colors.green,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      List<String> Datas = [];
                      // Process your data here
                      // print('Category ID: $categoryId');
                      // print('Question: $question');
                      for (int i = 0; i < textEditingController.length; i++) {
                        Datas.add(textEditingController[i].text.toString().trim());
                      }

                      Question _question = Question(question: question!, option: Datas, Cid: categoryId, Answer: answer!);
                      addQuestion(_question, context);
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  buildcategoryFormFiled() {
    return Container(
      width: MediaQuery.of(context).size.width, // Full-width container
      // Adjust the padding values as needed
      child: DropdownButtonFormField(
        // Assigning the default value
        iconEnabledColor: Colors.black45,
        validator: (value) {
          if (value == null) {
            return 'Select category type';
          } else {
            return null;
          }
        },
        onSaved: (newValue) {},
        onChanged: (value) {
          setState(() {
             categoryId = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: "Category",
          hintText: 'Select Category',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        items: categoryList.map((cate) {
          return DropdownMenuItem(
              value: cate.id, child: Text('${cate.CategoryName}'));
        }).toList(),
      ),
    );
  }
  buildQuesForm(){
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onSaved: (newValue) {
        question = newValue.toString();
        },
        validator: (value){
        if(value == null || value.isEmpty) {
          return 'Enter the Question';
        } else {
          return null;
        }
        },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Question",
        hintText: 'Enter the question',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
  buildAnswerForm(){
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        answer = newValue.toString();
      },
      validator: (value) {
        if(value!.trim().toString().isEmpty || value == null){
          return "Enter the Answer";
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Answer",
        hintText: 'Answer',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
