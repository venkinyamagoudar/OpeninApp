# OpeninApp iOS Developer Assignment

## Overview

This project involves building UI components for an iOS application called OpeninApp, which aims to enhance user experiences for social media links by opening them in the respective apps rather than in the browser. The assignment includes creating UI components and populating data from an API response.

### Architecture Used

The project follows a Model-View-ViewModel (MVVM) architecture pattern.

- **Model:** Includes data model structs such as `DashboardDataModel`, `Link`, and others.
- **View:** SwiftUI views responsible for presenting the UI components.
- **ViewModel:** `LinkViewModel` class acts as a bridge between the View and Model layers, managing data fetching, processing, and business logic.

### Requirements

- Xcode: The project is developed using Xcode, Apple's integrated development environment for macOS.
- Swift: The programming language used for iOS app development.
- SwiftUI: Used for building the user interface components declaratively.
- iOS SDK: Required for accessing iOS system frameworks and building native iOS applications.
- Internet Connection: Necessary for fetching data from the API endpoint.

### Technologies Used

- **Swift:** The primary programming language for iOS app development.
- **SwiftUI:** Apple's modern UI framework for building user interfaces across all Apple platforms.
- **Combine Framework:** Used for handling asynchronous events and data flow in the MVVM architecture.
- **URLSession:** Apple's networking framework for making HTTP requests and fetching data from remote servers.
- **JSONDecoder:** Used for parsing JSON data received from the API endpoint into Swift data models.
- **UIKit:** Certain UIKit components like `UIApplication` are utilized for interacting with the iOS system.
- **Caching:** Implementations of caching mechanisms for storing data in memory and disk respectively.Used FileManager for caching.

These technologies combined enable the development of a responsive and efficient iOS application with a modern user interface and seamless data fetching capabilities.
