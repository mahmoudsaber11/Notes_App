import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_state.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';

import '../../components/components.dart';
import 'add_note_form.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteErrorState) {}
          if (state is AddNoteSuccessState) {
            NotesCubit.get(context).fetchAllNotes();
            showToast(
              text: 'Success Add Note',
              state: ToastStates.SUCCESS,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! AddNoteLoadingState,
              builder: ((context) => Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const SingleChildScrollView(child: AddNoteForm()),
                  )),
              fallback: ((context) => const Center(
                    child: CircularProgressIndicator(),
                  )));
        },
      ),
    );
  }
}
