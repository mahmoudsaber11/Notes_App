import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/notes_state.dart';
import 'package:notes_app/model/note_model.dart';

import 'custom_note_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NoteModel> notes =
            BlocProvider.of<NotesCubit>(context).notes ?? [];
        return Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: ((context, index) => NoteItem(
                    noteModel: notes[index],
                  )),
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: 4,
                );
              }),
              itemCount: notes.length),
        );
      },
    );
  }
}
