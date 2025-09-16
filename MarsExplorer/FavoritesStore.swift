import SwiftUI

// This class will manage our favorites, and notify views when they change.
@MainActor
class FavoritesStore: ObservableObject {
    @Published private(set) var photos: [Photo]
    private let userDefaultsKey = "favorites"

    init() {
        // Load saved photos from UserDefaults when the app starts
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decodedPhotos = try? JSONDecoder().decode([Photo].self, from: data) {
                self.photos = decodedPhotos
                return
            }
        }
        self.photos = []
    }
    
    func contains(_ photo: Photo) -> Bool {
        photos.contains { $0.id == photo.id }
    }

    func toggle(_ photo: Photo) {
        if contains(photo) {
            // Remove the photo
            photos.removeAll { $0.id == photo.id }
        } else {
            // Add the photo
            photos.append(photo)
        }
        save()
    }
    
    private func save() {
        if let encodedData = try? JSONEncoder().encode(photos) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
}
