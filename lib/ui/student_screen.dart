import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:studentdb/model/student.dart';
import 'package:flutter/material.dart';


class StudentScreen extends StatefulWidget {
  final Student student;
  StudentScreen(this.student);
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentScreenState extends State<StudentScreen> {
  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _cityController;
  TextEditingController _departmentController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _cityController = TextEditingController(text: widget.student.city);
    _departmentController = TextEditingController(text: widget.student.department);
    _descriptionController =TextEditingController(text: widget.student.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Student DB'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              controller: _nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              controller: _ageController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Age',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              controller: _cityController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'City',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              controller: _departmentController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Department',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              controller: _descriptionController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Description',
              ),
            ),
            FlatButton(
                child:
                (widget.student.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.student.id != null) {
                    studentReference.child(widget.student.id).set({
                      'name': _nameController,
                      'age': _ageController,
                      'city': _cityController,
                      'department': _departmentController,
                      'Description': _descriptionController,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    studentReference.push().set({
                      'name': _nameController.text,
                      'age': _ageController.text,
                      'city': _cityController.text,
                      'department': _departmentController.text,
                      'Description': _descriptionController.text,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}
