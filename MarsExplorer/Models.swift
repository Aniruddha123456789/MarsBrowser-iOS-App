// This is the updated code for Models.swift

import Foundation

struct ApiResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover // NEW: Added rover information
    
    // This maps the JSON keys to our Swift properties
    private enum CodingKeys: String, CodingKey {
        case id, sol, camera, rover
        case imgSrc = "img_src"
        case earthDate = "earth_date"
    }
}

struct Camera: Codable {
    let name: String
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

// NEW: A struct to hold information about the rover
struct Rover: Codable {
    let name: String
    let landingDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case landingDate = "landing_date"
    }
}
