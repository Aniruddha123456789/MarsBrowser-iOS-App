# MarsBrowser 🚀

An advanced, multi-feature iOS app for exploring Mars, built entirely with SwiftUI. This app fetches and displays live data from official NASA Open APIs, allowing users to browse a massive catalog of photos from rovers like Curiosity, Perseverance, Spirit, and Opportunity.

## 📸 Screenshots

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-16 at 09 16 39" src="https://github.com/user-attachments/assets/aa874898-9c63-454a-93ad-252364143292" />



## ✨ Features

- **Multi-Rover Support:** Browse photos from Curiosity, Opportunity, Spirit, and Perseverance.
- **Interactive Date Picker:** An intuitive calendar interface to select the exact date of photos to view.
- **Rover Location Mapping:** On the detail screen, an interactive map shows the rover's location on Mars for the selected Sol using real geospatial data.
- **Favorites System:** Save your favorite photos with a tap. Favorites are stored locally on the device using `UserDefaults` and are available in a dedicated "Favorites" tab.
- **Share Functionality:** Natively share any Mars photo using the iOS Share Sheet.
- **Modern UI:** Built with SwiftUI, the app features a tab-based interface, asynchronous image loading, and handles loading and empty states for a smooth user experience.

## 🛠️ Technologies Used

- **SwiftUI:** For building the user interface and managing app state.
- **MapKit:** To display rover location data on an interactive map.
- **URLSession & Swift Concurrency (`async/await`):** For all networking to fetch data from multiple NASA API endpoints.
- **Codable:** For parsing complex JSON data from the API.
- **UserDefaults:** For local data persistence to save user's favorite photos.

## How to Run

1.  Clone the repository.
2.  You will need a free API key from [api.nasa.gov](https://api.nasa.gov/).
3.  Open the `NasaAPIService.swift` file and replace the placeholder with your personal API key.
4.  Build and run the project in Xcode.
