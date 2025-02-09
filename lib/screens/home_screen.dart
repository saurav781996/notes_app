import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/view_note_screen.dart';

import '../model/notes_model.dart';
import '../services/database_helper.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final DataBaseHelper _dateBaseHelper = DataBaseHelper();
  List<Note> _notes = [];
  List<Color> _notesColors = [
    Colors.amber,
    Color(0xFF50C878),
    Colors.redAccent,
    Colors.blueAccent,
    Colors.indigo,
    Colors.purpleAccent,
    Colors.pinkAccent,
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotes();
  }


  Future<void> _loadNotes() async{
    final notes =  await _dateBaseHelper.getNotes();
    setState(() {
      _notes = notes;
      debugPrint( "nootes "+ notes.first.title);
    });
  }

  String _formateDateTime(String dateTime){
    final DateTime dt =  DateTime.parse(dateTime);
    final now = DateTime.now();

    if(dt.year == now.year && dt.month ==  now.month && dt.day == now.day){
      return 'Today, ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(0,'0')}';

  }
    return '${dt.day}/${dt.month}/${dt.year},${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(0,'0')}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("My Notes",
        style: TextStyle(color: Colors.black45)),
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 16,mainAxisSpacing: 16
          ),
          itemCount: _notes.length,
          itemBuilder: (context,index){
            final note = _notes[index];
            final color =  Color(int.parse(note.color));
            return GestureDetector(
              onTap: ()async{
                await Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNoteScreen(note:note)));
              _loadNotes();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2)
                  ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(note.content,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(_formateDateTime(note.dateTime),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNoteScreen()));
        _loadNotes();
      },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF50C878),
        foregroundColor: Colors.white,
      ),
    );
  }
}
