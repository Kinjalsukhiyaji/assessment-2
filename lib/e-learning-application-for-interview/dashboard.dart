import 'package:e_learning_application/e-learning-application-for-interview/about%20us.dart';
import 'package:e_learning_application/e-learning-application-for-interview/contactus.dart';
import 'package:e_learning_application/e-learning-application-for-interview/managecategory.dart';
import 'package:e_learning_application/e-learning-application-for-interview/playquiz.dart';
import 'package:e_learning_application/e-learning-application-for-interview/readquiz.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'createquestion.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> quizCategories = ['Play Quiz', 'Read Quiz'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Add logic to handle menu item selection
            if (value == 'logout') {
              // Perform logout actions
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else if (value == 'Category') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Manage_Category()));
            }else if (value == 'Manage questions') {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageQuestion()));
                // Navigate to home page
              } else if (value == 'AboutUs') {
                // Navigate to about us page
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsScreen()));
              } else if (value == 'ContactUs') {
                // Navigate to contact us page
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsScreen()));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Category',
                child: Text('Manage Category'),
              ),
              PopupMenuItem<String>(
                value: 'Manage questions',
                child: Text('Manage Questions'),
              ),
              PopupMenuItem<String>(
                value: 'AboutUs',
                child: Text('About Us'),
              ),
              PopupMenuItem<String>(
                value: 'ContactUs',
                child: Text('Contact Us'),
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          DashboardOption(
            title: 'Play Quiz',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayQuizPage()),
              );
            },
          ),
          DashboardOption(
            title: 'Read Questions',
            onTap: () {
              // Implement logic for reading questions
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadQuiz()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DashboardOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  DashboardOption({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}