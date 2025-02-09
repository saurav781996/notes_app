import 'package:flutter/material.dart';
import 'package:notes_app/screens/add_edit_screen.dart';

import '../model/notes_model.dart';
import '../services/database_helper.dart';

class ViewNoteScreen extends StatelessWidget {
  final Note note;

  ViewNoteScreen({required this.note});

  final DataBaseHelper _dateBaseHelper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(note.color)),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              color: Colors.white),
          actions: [
          IconButton(
          onPressed: () async {
    await Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AddEditNoteScreen(
    note: note,
    ),
    ),
    );
    },
      icon: Icon(
        Icons.edit,
        color: Colors.white,
      ),),
            IconButton(
              onPressed: () => _showDeleteDialog(context), // Missing comma fixed
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
            ,
    SizedBox(width: 8,)
    ],
    ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12), // Fixed: SizedBox should be closed here
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        (note.dateTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32)
                )
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Text(note.content,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black.withOpacity(0.8),
                  height: 1.6,
                  letterSpacing: 0.2
                ),),
              ),
            ))
          ],
        ),
      )
      ,
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirm = await showDialog(context: context, builder: (context) =>
        AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          title: Text(
            "Delete Note",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to delete this note", style: TextStyle(
              color: Colors.black54,
              fontSize: 16
          ),),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel", style: TextStyle(color: Colors.grey[600],
                fontWeight: FontWeight.w600
                ),)),
            TextButton(onPressed: () => Navigator.pop(context, true),
                child: Text(
                  "Delete", style: TextStyle(color: Colors.grey[600],
                    fontWeight: FontWeight.w600
                ),))
          ],

        ));

    if(confirm == true){
      await _dateBaseHelper.deleteNote(note.id!);
      Navigator.pop(context);
    }
  }

}
