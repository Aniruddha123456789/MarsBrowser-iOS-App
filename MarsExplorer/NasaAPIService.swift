// This is the complete code for NasaAPIService.swift

import Foundation

// An enum for the rovers to prevent typos
enum RoverName: String, CaseIterable {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
    case perseverance = "Perseverance"
}

// A struct to hold the decoded location data for a specific Sol
struct RoverLocation: Codable {
    let sol: Int
    let lat: Double
    let lon: Double
}

// Helper structs to decode the complex manifest JSON
struct ManifestResponse: Codable {
    let photoManifest: PhotoManifest
    
    private enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}

struct PhotoManifest: Codable {
    let photos: [RoverLocation]
}


class NasaAPIService {
    // IMPORTANT: Make sure to replace this with your personal key from api.nasa.gov
    private let apiKey = "duBQyPmghRL4jOBdkbZK89Pjq0LUhty4wVtWS4I7"
    
    /// Fetches photos for a specific rover and date.
    func fetchPhotos(for rover: RoverName, on date: Date, page: Int) async throws -> [Photo] {
        // Create a date formatter for the YYYY-MM-DD format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        // Use the rover's rawValue (its name as a string) for the URL
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover.rawValue.lowercased())/photos?earth_date=\(dateString)&page=\(page)&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Fetch data from the URL asynchronously
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the JSON data into our Swift models
        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
        
        return apiResponse.photos
    }
    
    /// Fetches the mission manifest for a rover to find location data for a specific Sol.
    func fetchLocation(for rover: RoverName, on sol: Int) async throws -> RoverLocation? {
        // The URL for the rover's mission manifest
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/manifests/\(rover.rawValue.lowercased())?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // We need to parse the manifest JSON, which has a nested structure
        let manifestData = try JSONDecoder().decode(ManifestResponse.self, from: data)
        
        // Find the location data for the specific sol we are interested in
        return manifestData.photoManifest.photos.first { $0.sol == sol }
    }
}
