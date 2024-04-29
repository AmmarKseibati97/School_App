# ASchool App

ASchool App is a Flutter application designed to manage student attendance, offering features such as check-in, check-out, and absence management. This document provides an overview of the app's functionality, features, setup instructions, and additional considerations.

## Features

- **User Authentication:**
    - Implement user authentication for teachers/admins.
    - Teachers can log in and access attendance features.

- **Student List:**
    - Display a list of students with names and IDs.
    - Fetch student data from a mock API.

- **Check-in/Check-out:**
    - Enable teachers to mark student check-ins and check-outs.
    - Record timestamps for each check-in and check-out action.

- **Absent Management:**
    - Allow marking students as absent for specific dates.
    - Provide an optional reason for the absence.
    - View a history of student absences.

- **Attendance Summary:**
    - Display a summary of daily attendance (present, absent, checked-out).

- **State Management:**
    - Utilize a state management solution (Bloc/Cubit).

- **Database Integration:**
    - Integrate a database (Firebase) for student data and attendance records.

- **Responsive UI:**
    - Ensure a responsive and user-friendly UI across different screen sizes.

- **Testing:**
    - Write unit tests for critical application logic.
    - Implement widget tests for UI components using `flutter_test`.

- **Git:**
    - Use version control with Git.
    - Commit changes with meaningful messages.
    - Push code to a GitHub repository.

- **Localization:**
    - Localize strings for English and Arabic.

- **Search Functionality:**
    - Implement student search functionality.

- **Edge Cases:**
    - Handle network errors, invalid input, and other edge cases.

## Additional Considerations

- **Best Practices:**
    - Follow Flutter best practices and guidelines.

- **Flavors:**
    - Set up flavors for DEV, STAGE, and PROD environments.

- **Real-time Updates:**
    - Consider real-time updates for attendance changes (if applicable).

## Setup Instructions

1. **Clone Repository:**
   ```bash
   git clone https://github.com/AmmarKseibati97/A_School_App

2. **Navigate to Project Directory:**
   ```bash
   cd a_school_app

3. **Install Dependencies:**
   ```bash
   flutter pub get

4. **Run the App:**
   ```bash
   flutter run --flavor staging -t lib/main_development.dart
