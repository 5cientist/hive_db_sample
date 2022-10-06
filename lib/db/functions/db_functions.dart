import 'package:flutter/foundation.dart';
import 'package:hive_db_sample/db/models/data_model.dart';
import 'package:hive_flutter/adapters.dart';

// List<StudentModel> studentList = [];
ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  // studentListNotifier.value.add(value);

  final studenDB = await Hive.openBox<StudentModel>('student_db');
  final _id = await studenDB.add(value);
  value.id = _id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudent() async {
  final studenDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studenDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studenDB = await Hive.openBox<StudentModel>('student_db');
  await studenDB.delete(id);
  getAllStudent();
}
