import SwiftUI
import CoreLocation

struct PhotoDetailView: View {
    let photo: Photo
    @EnvironmentObject var favoritesStore: FavoritesStore
    
    @State private var location: RoverLocation?
    
    private let apiService = NasaAPIService()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: photo.imgSrc)) { image in
                    image.resizable().aspectRatio(contentMode: .fit).cornerRadius(12)
                } placeholder: {
                    ProgressView().frame(height: 300)
                }
                
                if let location = location {
                    VStack(alignment: .leading) {
                        Text("Rover Location (Sol \(location.sol))")
                            .font(.title2)
                            .fontWeight(.bold)
                        MapView(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon))
                            .frame(height: 250)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Photo Details").font(.largeTitle).fontWeight(.bold)
                    Divider()
                    InfoRow(label: "Earth Date", value: photo.earthDate)
                    InfoRow(label: "Martian Sol", value: "\(photo.sol)")
                    InfoRow(label: "Camera", value: photo.camera.fullName)
                    Divider()
                    InfoRow(label: "Rover", value: photo.rover.name)
                    InfoRow(label: "Landing Date", value: photo.rover.landingDate)
                }
                .padding()
            }
        }
        .navigationTitle("Photo #\(photo.id)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        favoritesStore.toggle(photo)
                    } label: {
                        Image(systemName: favoritesStore.contains(photo) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    
                    ShareLink(item: URL(string: photo.imgSrc)!) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .task {
            do {
                self.location = try await apiService.fetchLocation(for: RoverName(rawValue: photo.rover.name) ?? .curiosity, on: photo.sol)
            } catch {
                print("Failed to fetch location: \(error)")
            }
        }
    }
}

// THIS IS THE MISSING PIECE OF CODE
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label).font(.headline)
            Spacer()
            Text(value).font(.body).foregroundColor(.secondary).multilineTextAlignment(.trailing)
        }
    }
}
