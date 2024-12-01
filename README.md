# IoT-Connected Health App Prototype

## Overview
This project is a Flutter-based mobile application designed to simulate IoT device interactions, specifically focusing on Bluetooth and Wi-Fi devices. It features a clean user interface and integrates with a Flask-based backend for real-time sensor data visualization. The app fetches simulated sensor data, displays the current connected Wi-Fi information, and allows users to manage BLE/Wi-Fi devices.

The main objective of this project is to demonstrate how to handle device data and simulate interactions with IoT devices such as Bluetooth and Wi-Fi.

---

## Features
- **Bluetooth/Wi-Fi Device Simulation**: Simulated Bluetooth and Wi-Fi devices that can be added dynamically by the user.
- **Sensor Data Fetching**: Real-time data from a backend Flask server to simulate sensor readings like heart rate and temperature.
- **Wi-Fi Information**: Fetches and displays the current Wi-Fi network information such as SSID, BSSID, and IP address.
- **BLE/Wi-Fi Device Management**: Allows users to add and view both Bluetooth and Wi-Fi devices.

---

## Technologies Used
- **Frontend**: Flutter, Dart
- **Backend**: Flask, Python
- **API**: REST API (Flask for data fetching)
- **Packages**: 
  - `flutter_blue` (for Bluetooth simulation)
  - `wifi_info_flutter` (for fetching Wi-Fi information)
  - `fl_chart` (for sensor data visualization)

---

## Installation

### Prerequisites
- **Flutter SDK** (version 3.0 or higher) installed. To install Flutter, refer to the official documentation [here](https://flutter.dev/docs/get-started/install).
- **Dart SDK** (included with Flutter).
- **Python** (for Flask backend, version 3.7 or higher).

### Steps to Run the App

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/mayankyadav06/Flutter-IoT-Health-App.git
   cd iot-connected-health-app
   ```

2. **Install Flutter Dependencies**:
   In the project root folder, run the following command to install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. **Start Flask Server**:
   - Navigate to the `flask_backend` directory:
     ```bash
     cd flask_backend
     ```
   - Install the required Python packages:
     ```bash
     pip install flask flask-cors
     ```
   - Start the Flask server:
     ```bash
     python app.py
     ```
   - The server will start at `http://127.0.0.1:5000/`. The app will interact with this server to fetch sensor data.

4. **Run the Flutter App**:
   - Back in the Flutter project directory, run the app:
     ```bash
     flutter run
     ```
   - The app should now be running on your emulator or physical device. Change the IP address to your own IP address in case of running on physical device in `lib\providers\sensor_data_provider.dart`.

---

## Explanation of Bluetooth and Wi-Fi Simulation
The Bluetooth and Wi-Fi simulation in this app allows the user to interact with mock devices without requiring actual hardware or network connectivity. Below is a detailed step-by-step explanation of how this simulation works for both Bluetooth and Wi-Fi:

### Simulated Bluetooth Devices:
1. **Mock Bluetooth Devices**: The app simulates a list of Bluetooth devices that can be viewed and interacted with. These devices are displayed with a name (e.g., “Blue 1”, “Blue 2”) and a connection type, which is Bluetooth in this case. The user can browse through these devices as if they were real Bluetooth devices available for connection.
   
2. **Device Interaction**: While the app does not establish real Bluetooth connections, it allows the user to simulate selecting these devices for interaction. This means the user can view a list of simulated Bluetooth devices, select one, and interact with it as though the device were connected, all while using predefined data.

### Simulated Wi-Fi Devices:
1. **Mock Wi-Fi Devices**: The app simulates Wi-Fi devices that are displayed with a name (e.g., “Wifi 1”, “Wifi 2”) and a connection type (Wi-Fi). Each simulated Wi-Fi device is also associated with a password (e.g., “pass12”, “pass34”) for simulation purposes.

2. **Adding New Devices**: The app allows the user to add new Wi-Fi devices to the list. When a user adds a device, they input a name for the Wi-Fi device and, the password will be set to `pass` by default. These new devices are added to the list of Wi-Fi devices and can be selected by the user, just like the pre-existing ones.

3. **Wi-Fi Connection Simulation**: Although the app doesn't actually connect to Wi-Fi networks, it simulates the process of selecting a Wi-Fi device, providing the illusion of a device connection. The simulated Wi-Fi devices behave as if they were real, allowing users to interact with them in a similar way to how they would with actual Wi-Fi networks.

### Simulation Workflow:
- **Adding Devices**: Users can add both Bluetooth and Wi-Fi devices to the app by providing a name and selecting the connection type. This allows them to simulate the process of discovering and connecting to new devices.
- **Interaction with Devices**: Once added, the devices appear in their respective categories (Bluetooth or Wi-Fi) within the app, and the user can simulate selecting a device for connection. The app does not perform actual connection operations but mimics the behavior of interacting with such devices.
- **Display of Device Information**: The app displays the device names, connection types, providing a realistic experience of viewing and selecting IoT devices.

This simulation of Bluetooth and Wi-Fi devices allows users to test and explore the app’s functionality without needing physical devices, making it easier to develop and test IoT-related features in the app.

---

## Dual Theme Mode
The app supports light and dark themes, allowing users to switch between them based on their preference. This feature enhances user experience and accessibility.

### Implementation:
- State Management: The app uses a ThemeProvider class, which handles the current theme mode.
- Dynamic Theme Switching: The user can toggle between light and dark themes using a toggle button in the app settings.
  
### Key Benefits:
- Better readability and reduced eye strain in low-light environments with the dark mode.
- A modern, customizable look that adapts to user preferences.


---
## Real-Time Sensor Data Fetching
The app fetches real-time sensor data (such as temperature and heart rate) from the Flask server:
- The data is fetched using an HTTP GET request to the Flask API endpoint `http://127.0.0.1:5000/api/sensor_data`.
- The sensor data is processed and displayed on a graph using the `fl_chart` package.

### Backend API
- Endpoint: http://`IP_ADDRESS`:5000/api/sensor_data
- Description: This endpoint simulates real-time sensor data retrieval for connected health monitoring.
Response Example:
```json
{
  "temperature": 36.6,
  "heartRate": 72,
}
```

---

## Key Provider Classes
- `CurrentScreenProvider`: Manages navigation state for the main screens.
- `DeviceProvider`: Handles mock BLE/Wi-Fi devices and user-defined additions.
- `LoadingProvider`: Manages the loading state for various app processes.
- `SensorDataProvider`: Fetches and processes real-time sensor data from the API.
- `WiFiInfoProvider`: Retrieves and displays current Wi-Fi details (e.g., SSID, BSSID, IP).


![IMG-20241201-WA0005](https://github.com/user-attachments/assets/a156ddb7-47ad-43f5-b426-27f2647441fa)

![IMG-20241201-WA0006](https://github.com/user-attachments/assets/074c4cd9-0e2e-4730-b380-bef522d5d1b4)
![IMG-20241201-WA0004](https://github.com/user-attachments/assets/85a0dff9-5ca3-4fea-af18-7386f3c9e2ed)
![IMG-20241201-WA0002](https://github.com/user-attachments/assets/cfc71f28-5a9d-46ab-8015-dd8c5eee14dd)
![IMG-20241201-WA0003](https://github.com/user-attachments/assets/e96faa70-cd67-4590-8849-32fec482d53a)





## Video Link
[https://drive.google.com/file/d/18DndY1i3QyLVgjNbRHx5c5e85bTNUHgG/view?usp=drivesdk](https://drive.google.com/file/d/18LKa79lXLU3Ea4KVe6Zd2yODPCqo0vxa/view?usp=sharing)


---
