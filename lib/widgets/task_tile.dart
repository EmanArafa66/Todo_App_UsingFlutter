// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/TaskDetailsScreen.dart';

// A stateless widget that represents a single task item in the task list
class TaskTile extends StatelessWidget {
  final Task task; // The task to be displayed
  final VoidCallback onEdit; // Callback when the edit action is triggered
  final VoidCallback onDelete; // Callback when the delete action is triggered
  final VoidCallback
      onFinish; // Callback when the finish/undo action is triggered

  TaskTile({
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final isFinished = task.finished ?? false; // Check if the task is finished
    final status = isFinished ? 'Done' : 'ToDo'; // Determine the status text

    return Card(
      margin: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Margin around the card
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0), // Padding inside the list tile
        leading: Container(
          width: 10, // Width of the color indicator
          color: Color(task.color ?? 0xFF000000), // Display the task color
        ),
        title: Text(
          'Task ${task.id}', // Display the task number
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('MM/dd/yyyy').format(task.dueDate)}', // Display the due date
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 4.0), // Space between elements
            Text(task.title ??
                'No Title'), // Display the task title or 'No Title'
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit(); // Trigger the edit callback
                } else if (value == 'delete') {
                  onDelete(); // Trigger the delete callback
                } else if (value == 'finish') {
                  onFinish(); // Trigger the finish callback
                } else if (value == 'undo') {
                  onFinish(); // Trigger the undo callback
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: isFinished ? 'undo' : 'finish',
                  child: Text(isFinished ? 'Undo' : 'Finish'),
                ),
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(width: 8.0), // Space between elements
            Container(
              width: 40, // Adjust width as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3, // Rotate text 90 degrees to be vertical
                    child: Text(
                      status, // Display the status text
                      style: TextStyle(
                        color: isFinished
                            ? Colors.green
                            : Colors.red, // Color based on status
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                  task: task.toMap()), // Navigate to task details screen
            ),
          );
        },
      ),
    );
  }
}
