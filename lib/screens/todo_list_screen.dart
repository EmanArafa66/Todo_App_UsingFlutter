// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/database_helper.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

// The main screen of the application that displays the to-do list
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  CalendarFormat _calendarFormat =
      CalendarFormat.month; // Default calendar format
  DateTime _selectedDay = DateTime.now(); // Initially selected day
  DateTime _focusedDay = DateTime.now(); // Initially focused day
  Map<DateTime, List<Task>> _tasks = {}; // Map to store tasks for each date
  Map<DateTime, int> _taskCounters =
      {}; // Map to store task counters for each date

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the screen initializes
  }

  // Function to load tasks from the database
  Future<void> _loadTasks() async {
    final tasks =
        await DatabaseHelper().tasks(); // Retrieve tasks from the database
    final Map<DateTime, List<Task>> tasksMap = {};
    for (var task in tasks) {
      final date =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      if (tasksMap[date] == null) {
        tasksMap[date] = [];
      }
      tasksMap[date]!.add(task);
    }
    setState(() {
      _tasks = tasksMap;
      _initializeTaskCounters();
    });
  }

  // Initialize task counters for each date
  void _initializeTaskCounters() {
    for (var date in _tasks.keys) {
      _taskCounters[date] = _tasks[date]!.length;
    }
  }

  // Get the next task number for a given date
  int _getNextTaskNumber(DateTime date) {
    return (_taskCounters[date] ?? 0) + 1;
  }

  // Renumber tasks for a given date
  void _renumberTasks(DateTime date) {
    if (_tasks[date] != null && _tasks[date]!.isNotEmpty) {
      setState(() {
        List<Task> tasks = List.from(_tasks[date]!);
        tasks.sort((a, b) => (a.id!).compareTo(b.id!));
        for (int i = 0; i < tasks.length; i++) {
          tasks[i] = tasks[i].copyWith(id: i + 1);
        }
        _tasks[date] = tasks;
        _taskCounters[date] = tasks.length;
      });
    }
  }

  // Remove a task for a given date and index
  void _removeTask(DateTime date, int index) async {
    Task taskToRemove = _tasks[date]![index];
    await DatabaseHelper()
        .deleteTask(taskToRemove.id!); // Delete task from database
    setState(() {
      _tasks[date]!.removeAt(index);
      if (_tasks[date]!.isEmpty) {
        _tasks.remove(date);
        _taskCounters.remove(date);
      } else {
        _renumberTasks(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String dayLabel =
        _getDayLabel(_selectedDay); // Get the label for the selected day
    String dynamicMessage =
        'What do you want to do $dayLabel?'; // Dynamic message for the day
    List<Task>? tasksForDay =
        _tasks[_selectedDay]; // Get tasks for the selected day

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'), // App bar title
        actions: [
          PopupMenuButton<CalendarFormat>(
            onSelected: (format) {
              setState(() {
                _calendarFormat = format; // Update calendar format
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: CalendarFormat.month,
                child: Text('Month View'),
              ),
              PopupMenuItem(
                value: CalendarFormat.twoWeeks,
                child: Text('2-Week View'),
              ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  dynamicMessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (tasksForDay == null || tasksForDay.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/no_tasks.png',
                          height: 150,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Tap + to add your tasks',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  final task = tasksForDay[index];
                  return TaskTile(
                    task: task.copyWith(id: index + 1), // Add task number
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskScreen(
                            task: task.toMap()..['number'] = index + 1,
                          ),
                        ),
                      ).then((updatedTask) {
                        if (updatedTask != null) {
                          setState(() {
                            int taskIndex = tasksForDay.indexOf(task);
                            _tasks[_selectedDay]![taskIndex] =
                                Task.fromMap(updatedTask).copyWith(id: task.id);
                            _renumberTasks(_selectedDay);
                          });
                        }
                      });
                    },
                    onDelete: () {
                      _removeTask(_selectedDay, index);
                    },
                    onFinish: () {
                      setState(() {
                        Task updatedTask =
                            task.copyWith(finished: !(task.finished ?? false));
                        _tasks[_selectedDay]![index] = updatedTask;
                        DatabaseHelper().updateTask(updatedTask);
                      });
                    },
                  );
                }
              },
              childCount: tasksForDay == null ? 1 : tasksForDay.length,
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 16.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskMap = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );

          if (newTaskMap != null) {
            final newTask = Task.fromMap(newTaskMap);
            await DatabaseHelper().insertTask(newTask);

            setState(() {
              if (_tasks[_selectedDay] == null) {
                _tasks[_selectedDay] = [];
              }
              final taskNumber = _getNextTaskNumber(_selectedDay);
              _tasks[_selectedDay]!.add(newTask.copyWith(id: taskNumber));
              _taskCounters[_selectedDay] = _tasks[_selectedDay]!.length;
              _renumberTasks(_selectedDay);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Get the label for the selected day
  String _getDayLabel(DateTime date) {
    DateTime today = DateTime.now();
    if (isSameDay(date, today)) {
      return 'Today';
    } else if (isSameDay(date, today.add(Duration(days: 1)))) {
      return 'Tomorrow';
    } else {
      return 'on ${date.day}/${date.month}/${date.year}';
    }
  }
}
