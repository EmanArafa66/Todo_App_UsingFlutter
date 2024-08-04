// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_app/models/task.dart';

// A stateful widget that represents the screen for adding or editing a task
class AddTaskScreen extends StatefulWidget {
  final Map<String, dynamic>? task; // Existing task data (if editing)

  AddTaskScreen({this.task}); // Constructor to accept the task data

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController =
      TextEditingController(); // Controller for the title input
  final _descriptionController =
      TextEditingController(); // Controller for the description input
  DateTime _dueDate = DateTime.now(); // Default due date is today
  bool _notify = false; // Default notification status
  Color _priorityColor = Colors.blue; // Default color

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      // Initialize with existing task data if editing
      _titleController.text = widget.task!['title'] ?? '';
      _descriptionController.text = widget.task!['description'] ?? '';
      _dueDate = DateTime.parse(widget.task!['dueDate']);
      _notify = widget.task!['notify'] == 1; // Convert integer to bool
      _priorityColor = Color(widget.task!['color']);
    }
  }

  // Method to handle task submission
  void _submitTask() {
    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _dueDate,
      notify: _notify,
      color: _priorityColor.value,
    );

    Navigator.pop(
        context, newTask.toMap()); // Close the screen with the new task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'), // Title of the AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title:', style: TextStyle(fontSize: 18)), // Title label
            TextField(
              controller: _titleController, // Controller for the title input
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Outline border for the input
                hintText: 'Enter task title', // Placeholder text
              ),
            ),
            const SizedBox(height: 16.0), // Space between elements
            Text('Description:',
                style: TextStyle(fontSize: 18)), // Description label
            TextField(
              controller:
                  _descriptionController, // Controller for the description input
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Outline border for the input
                hintText: 'Enter task description', // Placeholder text
              ),
              maxLines: 3, // Allow multiple lines
            ),
            const SizedBox(height: 16.0), // Space between elements
            Row(
              children: [
                Expanded(
                  child: Text('Due Date:',
                      style: TextStyle(fontSize: 18)), // Due date label
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today), // Calendar icon
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _dueDate) {
                      setState(() {
                        _dueDate = pickedDate; // Update due date
                      });
                    }
                  },
                ),
                Text(DateFormat('MM/dd/yyyy')
                    .format(_dueDate)), // Display the selected due date
              ],
            ),
            const SizedBox(height: 16.0), // Space between elements
            Row(
              children: [
                Text('Notify when getting closer:',
                    style: TextStyle(fontSize: 18)), // Notify label
                Switch(
                  value: _notify, // Current switch value
                  onChanged: (value) {
                    setState(() {
                      _notify = value; // Update switch value
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0), // Space between elements
            Text('Color for Priority of the Task:',
                style: TextStyle(fontSize: 18)), // Priority color label
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Color? selectedColor = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorPickerDialog(
                          initialColor: _priorityColor,
                        );
                      },
                    );
                    if (selectedColor != null) {
                      setState(() {
                        _priorityColor = selectedColor; // Update priority color
                      });
                    }
                  },
                  child: Text('Select Color'),
                ),
                const SizedBox(width: 8.0), // Space between elements
                Container(
                  width: 40, // Width of the color box
                  height: 40, // Height of the color box
                  color: _priorityColor, // Display the selected priority color
                ),
              ],
            ),
            const SizedBox(height: 16.0), // Space between elements
            ElevatedButton(
              onPressed: _submitTask, // Handle task submission
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// A stateless widget that represents the color picker dialog
class ColorPickerDialog extends StatelessWidget {
  final Color initialColor; // The initial color selected in the dialog

  ColorPickerDialog(
      {required this.initialColor}); // Constructor to accept the initial color

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor; // Variable to store the selected color

    return AlertDialog(
      title: Text('Pick a Color'), // Title of the dialog
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: initialColor, // Initial color
          onColorChanged: (color) {
            selectedColor = color; // Update selected color
          },
          showLabel: true, // Show color label
          pickerAreaHeightPercent: 0.8, // Height of the color picker area
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, selectedColor); // Return the selected color
          },
          child: Text('Select'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cancel the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
