import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditPage;
  final Function(String) deleteById; 
  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateToEditPage,
    required this.deleteById
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'].toString();

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.amber,
          child: Text('${index + 1}')
        ),
        title: Text(item['name']),
        subtitle: Text(item['email']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if(value == 'edit') {
              navigateToEditPage(item);
            }else if(value == 'delete') {
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              )
            ];
          },
        ),
      ),
    );
  }
}