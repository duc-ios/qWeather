[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# qWeather

qWeather is a powerful weather application that allows users to search for countries, mark them as favorites, and get accurate weather forecasts.

## Features

- **Country Searching:** Find weather information for any city in the world.
- **Favorite Countries:** Mark countries as favorites for quick access to their weather data.
- **Weather Forecasts:** Get detailed and reliable weather forecasts for your chosen locations.

## Requirements

- Xcode 15 or later
- iOS 16+
- Swift 5.9+
- An API key from [OpenWeatherMap](https://home.openweathermap.org/users/sign_up)

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/duc-ios/qWeather.git
cd qWeather
```

### 2. Configure API Key

To fetch weather data, you need to configure your OpenWeatherMap API key.

1. Open Configs.swift in the project.
2. Locate the OPEN_WEATHER_MAP_API_KEY placeholder.
3. Replace the placeholder with your actual API key from OpenWeatherMap.

```swift
static let appId = <#OPEN_WEATHER_MAP_API_KEY#>
```

### 3. Build and Run

Open the qWeather.xcodeproj file in Xcode, then build and run the project on your preferred simulator or device.

## Usage

1. Search for a City: Use the search bar to find the weather in any city.
2. Mark as Favorite: Tap the star icon next to the city to add it to your favorites.
3. View Weather Forecasts: Select any city from the list or favorites to view detailed weather forecasts.

## Contributing

If you find any issues or have feature requests, feel free to open an issue or submit a pull request. Contributions are welcome!

## Meta

Duc Nguyen – <ducnh.2012@gmail.com>

Distributed under the MIT license. See `LICENSE` for more information.

[https://github.com/duc-ios/qWeather](https://github.com/duc-ios/qWeather)

[swift-image]: https://img.shields.io/badge/swift-5.9-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
