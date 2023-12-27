import 'package:flutter/material.dart';
import '../DB_HElper/dbhelper.dart';
import '../model/category.dart';

class Manage_Category extends StatefulWidget {
  Manage_Category({super.key});

  @override
  State<Manage_Category> createState() => _Manage_CategoryState();
}

class _Manage_CategoryState extends State<Manage_Category> {
  final _globelKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  DBHelper dBhelper = DBHelper();

  List<Category> CategotysData = [];

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var tempList = await dBhelper.getCategoryList();
    setState(() {
      CategotysData.addAll(tempList);
    });
  }
  Future<void> addcategory(Category category, BuildContext context) async {
    int id = await dBhelper.addcategory(category);
    if (id != -1) {
      category.id = id;
      print(id);
      Navigator.pop(context, category);
    } else {
      print("getting Error while adding category");
    }
  }

  Future<void> deleteData(Category category, BuildContext context) async {
    var id = await dBhelper.deleteCategory(category.id!);
  }

  Future<void> updateCategory(Category category, BuildContext context) async {
    var id = await dBhelper.updateCategory(category);
    if (id != -1) {
      print("Category Updated");
      print(category.id);
      Navigator.pop(context, category);
    } else {
      print("getting Error while adding category");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categroy"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Category? category = await openModelBottSheet(context, null);
          setState(() {
            CategotysData.add(category!);
          });
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: CategotysData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              Category category = CategotysData[index];

              Category? Cates =
                  await openModelBottSheet(context, category) as Category;
              if (Cates != null) {
                setState(() {
                  var index = CategotysData.indexWhere(
                      (element) => element.id == Cates.id);
                  CategotysData[index] = Cates;
                });
              }
            },
            trailing: IconButton(
                onPressed: () {
                  Category category = CategotysData[index];
                  deleteData(category, context);
                  setState(() {
                    CategotysData.removeWhere(
                        (element) => element.id == category!.id);
                  });
                },
                icon: Icon(Icons.delete)),
            title: Text(CategotysData[index].CategoryName!),
            leading: Text("${CategotysData[index].id}"),
          );
        },
      ),
    );
  }

  openModelBottSheet(BuildContext context, Category? category) {
    if (category == null) {
      _title.text = "";
      return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _globelKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Insert The Category",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: _title,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Enter the tital";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Divider(),
                          MaterialButton(
                            onPressed: () async {
                              String title = _title.text.trim().toString();
                              if (_globelKey.currentState!.validate()) {
                                Category category =
                                    Category(CategoryName: title);
                                addcategory(category, context);
                              }
                            },
                            minWidth: double.infinity,
                            color: Colors.purple.shade100,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Add Category"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      _title.text = category.CategoryName!;
      return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _globelKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Update The Category",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: _title,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Enter the title";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Divider(),
                          MaterialButton(
                            onPressed: () async {
                              String title = _title.text.trim().toString();
                              if (_globelKey.currentState!.validate()) {
                                Category catesId = Category.withId(
                                    CategoryName: title, id: category.id);
// addcategory(category,context);
                                updateCategory(catesId, context);
                              }
                            },
                            minWidth: double.infinity,
                            color: Colors.purple.shade100,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Update Category"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
