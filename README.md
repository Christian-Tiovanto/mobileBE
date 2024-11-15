# Flutter Mobile App

This repository contains the source code for the mobile application built using [Flutter](https://flutter.dev). Follow the instructions below to get the app up and running on your local machine or emulator.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the App](#running-the-app)

---

## Prerequisites

Before getting started, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) (or any other editor like Visual Studio Code)
- [Device or Emulator/Simulator](https://flutter.dev/docs/get-started/install)

## Installation

### Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/Christian-Tiovanto/mobileBE.git
```

## Configuration
## This step is very important
1. If you are using a real device
   - make sure your express-app(your computer) and flutter-app(your phone) connect to the same network 
   - change the baseHost variable from local-host to available ip-address
     - steps to see the available ip-address
     - run the ipconfig command if you are using windows
     - ![image](https://github.com/user-attachments/assets/b5a3c8b7-ec67-4c66-9655-db13817a2d7c)
     - based on the ipaddress that is listed, use the one where your flutter-app and express-app connected to, make sure they are in the same network.
   - after configuring the baseHost, make sure your basePort is the same as the express-app running port

## Running the App
To run the app on your connected device or emulator, use the following command:
```bash
  flutter run
```


