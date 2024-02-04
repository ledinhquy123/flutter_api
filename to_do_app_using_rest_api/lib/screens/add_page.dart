import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/services/todo_services.dart';
import 'package:to_do_app_using_rest_api/utils/snackbar_helper.dart';

class AddTodoApge extends StatefulWidget {
  final Map? todo;
  const AddTodoApge({
    super.key,
    this.todo
  });

  @override
  State<AddTodoApge> createState() => _AddTodoApgeState();
}

class _AddTodoApgeState extends State<AddTodoApge> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if(widget.todo != null) {
      isEdit = true;
      titleController.text = widget.todo!['name'];
      descriptionController.text = widget.todo!['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEdit 
          ? const Center(child: Text('Edit Todo')) 
          : const Center(child: Text('Add Todo'))
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isEdit ? const Text('Edit') : const Text('Submit')
            )
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final response = await TodoService.submitData(body);

    if(response) {
      titleController.text = '';
      descriptionController.text = '';

      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Creation User Success', color: Colors.green);
    }else {
      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Creation User Failed', color: Colors.red);
    }
  }

  Future<void> updateData() async {
    final todo = widget.todo;

    if(todo == null) {
      print('You can not call update without todo data');
      return;
    }
    final response = await TodoService.updateData(body, todo['id'].toString());
    if (response){
      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Creation User Success', color: Colors.green);
    }else {
      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Creation User Failed', color: Colors.red);
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "name": title,
      "email": description
    };
  }
}
