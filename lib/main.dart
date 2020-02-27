import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Quiz'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Quiz quiz = Quiz();
  List<Icon> genAnswer = [];

  showEndMessage() {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Quiz finished",
      desc: "Score: ${quiz.getTotalQUestions().toString()}",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              quiz.reset();
              genAnswer = [];
              Navigator.pop(context);
            });
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  //int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                quiz.getQuestions(),
                //quiz.questionList[questionNumber].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  print(quiz.getTotalQUestions());
                  if (quiz.getAnswer(true) == null) {
                    showEndMessage();
                  } else {
                    genAnswer.add(quiz.getAnswer(true));
                  }
                  //print(questionNumber);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quiz.getAnswer(false) == null) {
                    showEndMessage();
                  } else {
                    genAnswer.add(quiz.getAnswer(false));
                  }
                  //print(questionNumber);
                });
              },
            ),
          ),
        ),
        Row(
          children: genAnswer,
        ),
      ],
    );
  }
}
