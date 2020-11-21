import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lectureName;
  int lectureCredit = 1;
  double lectureLetterValue = 4;
  List<Lecture> allLectures;
  var formKey = GlobalKey<FormState>();
  double gpa;

  @override
  void initState() {
    super.initState();
    allLectures = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("CALCULATING GPA"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Lecture Name",
                              hintText: "Please enter a lecture name",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value.length > 0) {
                              return null;
                            } else
                              return "Please a validate lecture name";
                          },
                          onSaved: (newValue) {
                            lectureName = newValue;
                            setState(() {
                              allLectures.add(Lecture(lectureName,
                                  lectureLetterValue, lectureCredit));
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 2)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: lectureCredits(),
                                  value: lectureCredit,
                                  onChanged: (selectedCredit) {
                                    setState(() {
                                      lectureCredit = selectedCredit;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 2)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: lectureLetterValues(),
                                  value: lectureLetterValue,
                                  onChanged: (value) {
                                    lectureLetterValue = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ))),
            SizedBox(height: 20),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 70,
              child: Center(
                  child: Text(
                "GPA : $gpa",
                style: TextStyle(fontSize: 25.0),
              )),
            ),
            SizedBox(height: 20),
            Expanded(
                child: Container(
                    color: Colors.black,
                    child: ListView.builder(
                      itemBuilder: _createListItems,
                      itemCount: allLectures.length,
                    ))),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> lectureCredits() {
    List<DropdownMenuItem<int>> credits = [];
    for (int i = 1; i <= 10; i++) {
      credits.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Credit"),
      ));
    }
    return credits;
  }

  List<DropdownMenuItem<double>> lectureLetterValues() {
    List<DropdownMenuItem<double>> letters = [];

    letters.add(DropdownMenuItem(
        child: Text(
          "AA",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 4));
    letters.add(DropdownMenuItem(
        child: Text(
          "BA",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 3.5));

    letters.add(DropdownMenuItem(
        child: Text(
          "BB",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 3.0));
    letters.add(DropdownMenuItem(
        child: Text(
          "CB",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 2.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "CC",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 2.0));
    letters.add(DropdownMenuItem(
        child: Text(
          "DC",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 1.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "DD",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 1.0));
    letters.add(DropdownMenuItem(
        child: Text(
          "FF",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 0));

    return letters;
  }

  Widget _createListItems(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(allLectures[index].name),
      ),
    );
  }
}

class Lecture {
  String name;
  double letterValue;
  int credit;

  Lecture(this.name, this.letterValue, this.credit);
}
