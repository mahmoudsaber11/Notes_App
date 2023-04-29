import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_state.dart';
import 'package:notes_app/model/note_model.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitialState());
  static AddNoteCubit get(context) => BlocProvider.of(context);
  Color color = const Color(0xffAC3931);
  addNote(NoteModel note) async {
    note.color = color.value;
    emit(AddNoteLoadingState());
    var notesBox = Hive.box<NoteModel>('notes_box');
    notesBox.add(note).then((value) {
      emit(AddNoteSuccessState());
    }).catchError((error) {
      emit(AddNoteErrorState(error.toString()));
    });
  }
}
