# FlickerApp

FlickerApp is an iOS application built using **SwiftUI** and follows the **MVVMC (Model-View-ViewModel-Coordinator)** architecture pattern. It allows users to search for photos using the Flickr API, displaying them in a grid, and offering the ability to view details for each image.

---

## Features

- Search for images using **Flickr API**.
- Display results in a grid format.
- View details of individual images.
- Built using **SwiftUI** with **MVVMC** architecture for separation of concerns.
- Unit and UI testing implemented.

---

## Project Structure

The project is organized as follows:

## Description

- **Model**: Includes data models used to interact with the Flickr API.
- **Networking**: Manages API requests, includes a mock client for testing, and handles network calls.
- **Screens**: Houses the different views of the application with its ViewModels, including the main content view, detailed view, image grid, search bar.
- **Coordinator**: Contains all navigation logic.
- **Assets**: Stores asset files and icons used throughout the app.
- **CVS_FlickrTestAppTests**: Contains unit tests for the application.
- **CVS_FlickrTestAppUITests**: Includes UI tests to ensure the application's interface functions correctly.

## Screenshots: 
## 1. Landing Screen
<img width="416" alt="List" src="https://github.com/user-attachments/assets/60c5e0ac-b621-4a78-acbc-108976a67181">


## 2. Details Screen
<img width="424" alt="details" src="https://github.com/user-attachments/assets/ecfd614d-2e58-4a58-b685-29fcb023ff2e">



## Installation

Instructions for setting up the project locally.

### Prerequisites

- **Xcode 14.0** or later
- **Swift 5.7** or later
- **iOS 15.0** or later
- **CocoaPods** or **Swift Package Manager (SPM)** for dependencies (if any)

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/xTIVx/CVS_Test.git
