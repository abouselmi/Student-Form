import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:studentdb/model/student.dart';
import 'package:studentdb/ui/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:studentdb/ui/student_information.dart';

class ListViewStudent extends StatefulWidget {
  @override
  _ListViewStudentState createState() => _ListViewStudentState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _ListViewStudentState extends State<ListViewStudent> {
  String studentImage;
  List<Student> items;
  StreamSubscription<Event> _onStudentAddedSubscreption;
  StreamSubscription<Event> _onStudentChangedSubscreption;
  @override
  void initState() {
    super.initState();

     items = List();
    _onStudentAddedSubscreption =
        studentReference.onChildAdded.listen(_onStudentAdded);
    _onStudentChangedSubscreption =
        studentReference.onChildChanged.listen(_onStudentUpdated);
  }

  @override
  void dispose() {
    super.dispose();
    _onStudentAddedSubscreption.cancel();
    _onStudentChangedSubscreption.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student DB',debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student information'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                  Divider(height: 6.0,),
                /*Container(
                child: Center(
                child: '${items[position].studentImage}' == ''
                ? Text('No Image')
                    : Image.network(
                '${items[position].studentImage}'+'?alt=media',
                height: 200.0,
                width: 300.0,
                ),
                ),
                ),*/
                Card(
                child:   Row(
                children: <Widget>[

                      Expanded(
                        child: ListTile(
                            title: Text(
                              '${items[position].name}',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 22.0,
                              ),
                            ),
                            subtitle: Text(
                              '${items[position].description}',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14.0,
                              ),
                            ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(


                                 backgroundColor: Colors.orangeAccent,
                                  radius: 25.0,
                                  child: Text(
                                    '${position + 1}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => _navigateToStudentInfromation(
                                context, items[position])),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          onPressed: () => _deleteStudent(
                              context, items[position], position)),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            _navigateToStudent(context, items[position]),
                      )
                    ]),
                )],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.blueAccent,
            onPressed: () => _creatNewStudent(context)),
      ),
    );
  }

  void _onStudentAdded(Event event) {
    setState(() {
      items.add(Student.fromSnapShot(event.snapshot));
    });
  }

  void _onStudentUpdated(Event event) {
    var oldStudentValue =
        items.singleWhere((student) => student.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldStudentValue)] =
          Student.fromSnapShot(event.snapshot);
    });
  }

  void _deleteStudent(
      BuildContext context, Student student, int position) async {
    await studentReference.child(student.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToStudent(BuildContext context, Student student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentScreen(student)),
    );
  }

  void _navigateToStudentInfromation(
      BuildContext context, Student student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentInformation(student)),
    );
  }

  void _creatNewStudent(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              StudentScreen(Student(null, '', '', '', '', '', ''))),
    );
  }
}
