import 'package:firebase_database/firebase_database.dart';
import 'package:studentdb/model/student.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

class StudentScreen extends StatefulWidget {
  final Student student;
  StudentScreen(this.student);
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentScreenState extends State<StudentScreen> {
  File image;

  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _cityController;
  TextEditingController _departmentController;
  TextEditingController _descriptionController;

  picker() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    //File img=await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _cityController = TextEditingController(text: widget.student.city);
    _departmentController =
        TextEditingController(text: widget.student.department);
    _descriptionController =
        TextEditingController(text: widget.student.description);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

     // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Student DB'),
      ),

      backgroundColor: Colors.white,
      body: Container(

        //margin: EdgeInsets.only(top: 15.0),
child:ListView(children: <Widget>[
        //alignment: Alignment.center,
         Column(

          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
              controller: _nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
              controller: _ageController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Age',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
              controller: _cityController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'City',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
              controller: _departmentController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Department',
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
              controller: _descriptionController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Description',
              ),
            ),
            Container(child:Center(
              child: image == null ? Text('No Image') : Image.file(image),
            ),),
            FlatButton(
              child: (widget.student.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.student.id != null) {
                  studentReference.child(widget.student.id).set({
                    'name': _nameController.text,
                    'age': _ageController.text,
                    'city': _cityController.text,
                    'department': _departmentController.text,
                    'description': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  var now =
                      formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                  var fullImageName = 'images/${'item'}-$now' + '.jpg';
                  var fullImageName2 = 'images%2F${'item'}-$now' + '.jpg';

                  final StorageReference ref =
                      FirebaseStorage.instance.ref().child(fullImageName);
                  final StorageUploadTask task = ref.putFile(image);
                  var part1 = 'https://firebasestorage.googleapis.com/v0/b/student-2c316.appspot.com/o/';

                  var fullPathImage = part1 + fullImageName2;
                  studentReference.push().set({
                    'name': _nameController.text,
                    'age': _ageController.text,
                    'city': _cityController.text,
                    'department': _departmentController.text,
                    'description': _descriptionController.text,
                    'StudentImage': '$fullPathImage'
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            )
          ],
        ),
    ],) ),
      floatingActionButton: FloatingActionButton(
        onPressed: picker,
        child: Icon(Icons.camera_alt),
      ),

    );


  }
}
