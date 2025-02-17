# xpenso - Expense Tracker

xpenso is a Flutter-based mobile application designed to help users efficiently manage and track their expenses. This README provides an overview of the application's architecture, approach, and setup instructions.

## Architecture

xpenso follows a Model-View-Controller (MVC) architecture to ensure a clear separation of concerns, maintainability, and scalability.

-   **Model:** Represents the data and business logic. It includes classes for managing expenses, categories, and user preferences.
-   **View:**  The user interface built with Flutter widgets. It displays data from the Model and allows users to interact with the application.
-   **Controller:** Acts as an intermediary between the Model and the View. It handles user input, updates the Model, and refreshes the View.

## Approach

The development of xpenso follows an iterative approach, focusing on delivering a user-friendly and feature-rich expense tracking experience. Key aspects of the approach include:

-   **Clean Architecture:** Adherence to clean architecture principles promotes testability, maintainability, and scalability.
-   **State Management:** Leveraging `Provider` ensures efficient state management, facilitating seamless data flow and UI updates.
-   **UI/UX Design:** A strong emphasis on a simple, intuitive, and visually appealing user interface, utilizing Flutter's extensive widget library for a delightful user experience.
-   **Data Persistence:** Implementation of `hive_ce` for local data storage guarantees fast, reliable data persistence and offline accessibility.
-   **Firebase Integration:** Utilizing Firebase services like Authentication, Cloud Firestore to provide a robust backend.
-   **Third-party Libraries:** Using well-maintained and supported libraries to speed up development and ensure reliability.

## Getting Started

### Prerequisites

-   Flutter SDK installed on your machine.  ([Flutter Installation Guide](https://docs.flutter.dev/get-started/install))
-   Android Studio or VS Code with Flutter extension for development.

### Installation

1.  Clone the repository:

    ```sh
    git clone [<repository_url>](https://github.com/adhilfouzi/xpenso.git)
    ```
2.  Navigate to the project directory:

    ```sh
    cd xpenso
    ```
3.  Install dependencies:

    ```sh
    flutter pub get
    ```

### Running the App

1.  Connect a physical device or start an emulator.
2.  Run the app:

    ```sh
    flutter run
    ```

## Key Features

-   **Expense Tracking:** Easily add and categorize expenses.
-   **Budgeting:** Set monthly budgets and track spending against them.
-   **Reports & Analytics:** Visualize spending patterns with charts and reports.
-   **Category Management:** Customize expense categories.

## Dependencies

-   `provider`:  Used for managing the application's state, enabling efficient data sharing and UI updates.
-   `hive_ce`: A lightweight NoSQL database for local data storage, providing fast and reliable data persistence.
-   `flutter_keyboard_visibility`: Used to manage keyboard visibility.
-   `intl`:  For internationalization and localization, ensuring the app supports multiple languages and regions.
-   `firebase_auth`: For user authentication.
-   `firebase_core`: For core Firebase functionality.
-   `cloud_firestore`: For cloud database storage.
-   `google_sign_in`: For Google Sign-In authentication.
-   `http`: For making HTTP requests.
-   `package_info_plus`: For accessing package information.

## Contributing

Contributions are welcome!  Please follow these steps:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Implement your changes.
4.  Submit a pull request.

## License

[MIT](LICENSE)
