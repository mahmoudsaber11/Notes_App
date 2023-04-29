import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/model/note_model.dart';

import 'colors_list_view.dart';
import 'custom_buttom.dart';
import 'custom_textfield.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            hintText: 'Title',
            controller: titleController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            hintText: 'Content',
            height: 5,
            controller: subTitleController,
          ),
          const SizedBox(
            height: 32,
          ),
          const ColorsListView(),
          const SizedBox(
            height: 32,
          ),
          CustomButtom(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                var currentDate = DateTime.now();
                var formattedCurrentDate = DateFormat.yMd().format(currentDate);
                NoteModel noteModel = NoteModel(
                    title: titleController.text,
                    subTitle: subTitleController.text,
                    date: formattedCurrentDate,
                    color: Colors.blue.value);
                AddNoteCubit.get(context).addNote(noteModel);
                //setState(() {});
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
