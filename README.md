# Weather Tracker

Weather Tracker is a simple and efficient weather tracking app that provides accurate weather information using the WeatherAPI.

## Setup Instructions

Follow these steps to set up and run the project:

### 1. Clone the Repository

### 2. Configure the `Release.xcconfig` and `Debug.xcconfig` File
Copy the example configuration file to the correct location:
```bash
cp weather-tracker/Config/Release.xcconfig.example weather-tracker/Config/Release.xcconfig
cp weather-tracker/Config/Release.xcconfig.example weather-tracker/Config/Debug.xcconfig

```

### 3. Get the WeatherAPI Key
Obtain your WeatherAPI key by following the instructions on the [WeatherAPI Documentation](https://www.weatherapi.com/docs/).
- Add the API key to the `Release.xcconfig` and `Debug.config` files.

### 4. Link `.xcconfig` Files to Build Configurations
Ensure the `.xcconfig` files are properly linked to the build configurations in Xcode:

1. Open your project in Xcode.
2. Navigate to **Project Navigator** → **Info** tab.
3. Under the **Configuration** section:
   - Ensure the `Debug` configuration is pointing to `Debug.xcconfig`.
   - Ensure the `Release` configuration is pointing to `Release.xcconfig`.

### 5. Build and Run the Project
1. Select the appropriate target in Xcode.
2. Press `Cmd + R` to build and run the project.

## Features
- Search for weather information by location.
- Displays current weather conditions including temperature and weather icons.
- Save selected city to local storage for future reference. 
- Optimized for smooth user experience.

## Dependencies
- **WeatherAPI**: Used for fetching weather data.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
