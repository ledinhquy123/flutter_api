import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/screens/add_page.dart';
import 'package:to_do_app_using_rest_api/services/todo_services.dart';
import 'package:to_do_app_using_rest_api/utils/snackbar_helper.dart';
import 'package:to_do_app_using_rest_api/widget/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = false;
  List<dynamic> items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo App')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add Todo'),
      ),
      body: Visibility(
        visible: isLoading, // isLoading = true => hiển thị child, false => hiển thị replacement
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty, // true => hiển thị child
            replacement: Center(
              child: Text(
                'Nothing User',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return TodoCard(
                  index: index, 
                  item: item, 
                  navigateToEditPage: navigateToEditPage,
                  deleteById: deleteById,
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoApge()
    );
    await Navigator.push(context, route);

    setState(() {
      isLoading = false;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoApge(todo: item)
    );
    await Navigator.push(context, route);

    setState(() {
      isLoading = false;
    });

    fetchTodo();
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = false;
    });
    final success = await TodoService.fetchTodo();

    if(success.isNotEmpty) {
      final results = success;
      print('Fetch todo success');
      setState(() {
        items = results;
        isLoading = true;
      });
      
    }else {
      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Somthing went wrong', color: Colors.red);
      print('Fetch todo failed');
    }
  }

  Future<void> deleteById(String id) async {
    setState(() {
      isLoading = false;
    });
    final success = await TodoService.deleteById(id);
    if(success) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
        isLoading = true;
        fetchTodo();
      });
      print('Delete user success');
    }else {
      print('Delete user failed');
    }
  }
}