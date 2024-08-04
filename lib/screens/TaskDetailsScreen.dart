// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// A stateless widget that displays the details of a task
class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task; // The task to be displayed

  TaskDetailsScreen({required this.task}); // Constructor to accept the task

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'), // Title of the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'] ??
                  'No Title', // Display the task title or 'No Title'
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold), // Style for the title
            ),
            SizedBox(height: 16.0), // Space between elements
            Text(
              task['description'] ??
                  'No Description', // Display the task description or 'No Description'
              style: TextStyle(fontSize: 18), // Style for the description
            ),
            SizedBox(height: 16.0), // Space between elements
            Text(
              'Due Date: ${DateFormat('MM/dd/yyyy').format(DateTime.parse(task['dueDate']))}', // Display the due date
              style: TextStyle(fontSize: 16), // Style for the due date text
            ),
            SizedBox(height: 16.0), // Space between elements
            Row(
              children: [
                Text(
                  'Notify: ', // Label for the notify switch
                  style: TextStyle(fontSize: 16), // Style for the label
                ),
                Switch(
                  value: task['notify'] == 1, // Convert integer to bool
                  onChanged: null, // Disable the switch in details screen
                ),
              ],
            ),
            SizedBox(height: 16.0), // Space between elements
            Row(
              children: [
                Text(
                  'Priority Color: ', // Label for the priority color
                  style: TextStyle(fontSize: 16), // Style for the label
                ),
                Container(
                  width: 40, // Width of the color box
                  height: 40, // Height of the color box
                  color: Color(task['color']), // Display the priority color
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
