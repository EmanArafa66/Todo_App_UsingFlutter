# Todo List App

## Introduction
This project involves creating a mobile application with Todo list functionality using Flutter. The app is designed to manage tasks efficiently and offers features such as adding, deleting, editing, and reordering tasks.

## Objective
The objective of this project is to develop a mobile application using Flutter for managing tasks. The app implements innovative features to enhance the task management experience.

## Core Functionality
- **Add Task**: Users can add new tasks with a title, description, due date, notification option, and priority color.
- **Edit Task**: Users can edit the details of existing tasks.
- **Delete Task**: Users can delete tasks they no longer need.
- **Task Priority Colors**: Tasks can be color-coded based on their priority.

## User-Friendly Enhancement
One notable enhancement is the integration of task numbering. Each task is automatically assigned a unique number, which helps users keep track of their tasks in an organized manner. This feature contributes to the app’s usability by providing a clear, easy-to-follow sequence of tasks.

## User Interface
The interface is designed to be intuitive, accessible, and aesthetically pleasing. It incorporates the following elements:
- A clean and simple design for easy navigation.
- A calendar view for selecting and viewing tasks by date.
- Clearly labeled buttons and icons for adding, editing, and deleting tasks.
- A splash screen with the app logo for a smooth user experience.
- Color-coded task priorities for quick visual identification.

## Installation and Setup
1. **Clone the repository**:
   ```bash
   git clone https://github.com/EmanArafa66/Todo_App_UsingFlutter-.git
   cd Todo_App_UsingFlutter-
   
2. **Install dependencies**:
   ```bash
   flutter pub get
   
4. **Run the app**:
   ```bash
   flutter run

## Usage
**Adding a Task**:
 - Click the "+" button on the main screen.
 - Fill in the task details and select the priority color.
 - Click "Submit" to add the task.
   
**Editing a Task**:
 - Tap on a task to view its details.
 - Click the "Edit" button and modify the task details.
 - Click "Submit" to save the changes.
   
**Deleting a Task**:
- Tap on a task to view its details.
- Click the "Delete" button to remove the task.

## Additional Features and Improvements
- **Search Functionality:** Implement a search bar to find tasks quickly.
- **Category Tags**: Allow users to tag tasks with categories for better organization.
- **Recurring Tasks:** Add the ability to create recurring tasks (daily, weekly, monthly).
- **Dark Mode:** Provide a dark mode option for better user experience in low-light environments.


## File Structure
├── lib
│   ├── models
│   │   └── task.dart
│   ├── screens
│   │   ├── add_task_screen.dart
│   │   ├── splash_screen.dart
│   │   └── todo_list_screen.dart
│   ├── services
│   │   └── database.dart
│   ├── widgets
│   │   ├── color_picker.dart
│   │   └── task_tile.dart
│   └── main.dart
├── assets
│   └── images
│       └── todo.png
│       └── no_tasks.png
└── pubspec.yaml


