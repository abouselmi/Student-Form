import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:studentdb/model/student.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

class StudentInformation extends StatefulWidget {
  final Student student;
  StudentInformation(this.student);

  @override
  _StudentInformationState createState() => _StudentInformationState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentInformationState extends State<StudentInformation> {
  String studentImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentImage = widget.student.studentImage;
    print(studentImage);
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Student Information'),
      ),

      backgroundColor: Colors.white,
      body: Container(
        //margin: EdgeInsets.only(top: 10.0, left: 15.0),
        //alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: studentImage == ''
                  ? Text('No Image')
                  : Image.network(
                      studentImage +'?alt=media',
                      width: 150.0,
                      height: 100.0,
                    ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Text(
                    'Name:',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  Text('${widget.student.name}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      )),
                  Divider(),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  Text(
                    'Age:',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  Text('${widget.student.age}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      )),
                  Divider(),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  Text(
                    'City:',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  Text('${widget.student.city}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      )),
                  Divider(),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  Text(
                    'Depatement:',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  Text('     ${widget.student.department}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      )),
                  Divider(),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Text(
                    'Description:',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  Text('${widget.student.description}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      )),
                ],

    ),
            ),
          ],

        ),
      ),
    );
  }
}
