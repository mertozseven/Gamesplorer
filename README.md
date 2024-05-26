
<p align="center">
  <img src="https://github.com/mertozseven/Gamesplorer/assets/75128197/f1f09f1e-3666-46dd-b716-a44e07cd7d1c" width="150" height="150">
</p>

<div align="center">
  <h1>Gamesplorer - Turkcell Geleceği Yazanlar Bootcamp Third Project by Mert Adem Özseven</h1>
</div>

Welcome to Gamesplorer! Perfect companion for tracking latest and the most popular games 🚀. This app allows user to track most popular games and see in depth details of games. 

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Improvements](#improvements)

## Features

 **See Top Ranking Games:**
- Explore the most popular games listed by rank.
  
 **See In Depth Information About Games:**
- In Detail View of the game, there are screenshots and picrures of the game, metacritic score, description, release date, developer of the game and much more!

 ## Screenshots

| Image 1                | Image 2                | Image 3                |
|------------------------|------------------------|------------------------|
| ![splashDark](https://github.com/mertozseven/Gamesplorer/assets/75128197/7b5c3a2a-ac66-4d8d-87f6-d11ca65db249) | ![darkHome](https://github.com/mertozseven/Gamesplorer/assets/75128197/aec1b2ba-2ca7-4ee6-ac4e-280390285b3f) | ![darkDetail](https://github.com/mertozseven/Gamesplorer/assets/75128197/789734f1-5d3e-4054-a848-772d51d092e7) |
| Splash Screen (Dark Mode)    | Home (Dark Mode)    | Detail View (Dark Mode)    |

| Image 4                | Image 5                | Image 6                |
|------------------------|------------------------|------------------------|
| ![splashLight](https://github.com/mertozseven/Gamesplorer/assets/75128197/aab9efc7-6830-477c-97ea-3565d153a937) | ![lightHome](https://github.com/mertozseven/Gamesplorer/assets/75128197/269bfae4-6e75-4d17-875e-f2b51fc0bd4c) | ![lightDetail](https://github.com/mertozseven/Gamesplorer/assets/75128197/e35beebf-bed1-4027-aa12-82e9cf127147) |
| Splash Screen (Light Mode)    | Home (Light Mode)    | Detail View (Light Mode)    |

## Tech Stack

- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 17.0
- **Dependency Manager:** SPM
- **3rd Party Dependencies:** KingFisher

## Architecture

![mvvm](https://github.com/mertozseven/CryptoWatch/assets/75128197/b8afc54b-675f-40ac-abe1-87d4aeda153a)

In Gamesplorer's development, MVVM (Model-View-ViewModel) architecture is being used for these key reasons:

- **Enhanced Maintainability:**  MVVM facilitates a clean separation between the presentation logic and the business logic of the app. This separation makes it easier to manage and update the codebase as the app evolves.
- **Improved Testability:** The decoupling of the business logic from the UI components allows for more straightforward unit testing. Developers can focus on testing the logic behind the view model without worrying about the user interface.
- **Stronger Data Binding:** MVVM supports two-way data binding between the View and ViewModel, reducing the need for boilerplate code to synchronize the UI with the underlying data. This leads to less error-prone code and a smoother development process.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

Also, make sure that this dependency is added in your project's target:

- [Kingfisher](https://github.com/onevcat/Kingfisher):  Kingfisher is a lightweight and pure Swift library for downloading and caching images from the web.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/mertozseven/Gamesplorer.git
    ```

2. Open the project in Xcode:

    ```bash
    cd Gamesplorer
    open Gamesplorer.xcodeproj
    ```
3. Add required dependencies using Swift Package Manager:

   ```bash
   - Kingfisher
    ```

6. Build and run the project.

## Usage Video

<p align="left">
  <video src="https://github.com/mertozseven/Gamesplorer/assets/75128197/31651ce2-1950-4c25-ad3d-0d8220afa9d8" alt="Usage" width="200" height="400">
</p>

---

## Improvemets
- Sorting games could be added
- Localization for other languages can be added to be able to reach more user.
- Core data, Fire Base or UserDefaults integration for saved games. Other languages can be added to be able to reach more user.
- Search Functionality

- Core data, Fire Base or UserDefaults integration for saved coins.
