import SwiftUI

struct ContentView: View {
    @State private var photos = [Photo]()
    @State private var isLoading = false
    
    // NEW: State for the selected rover and date
    @State private var selectedRover: RoverName = .curiosity
    @State private var selectedDate: Date = Date()
    
    // This connects to the Favorites system we will build in Part 3
    @EnvironmentObject var favoritesStore: FavoritesStore
    
    private let apiService = NasaAPIService()
    
    var body: some View {
        NavigationStack {
            VStack {
                // --- NEW: Controls Section ---
                VStack {
                    Text("Select a Rover").font(.headline)
                    Picker("Select a Rover", selection: $selectedRover) {
                        ForEach(RoverName.allCases, id: \.self) { rover in
                            Text(rover.rawValue).tag(rover)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                }
                .padding()

                // --- UI States Section (Loading, Empty, Content) ---
                if isLoading {
                    Spacer()
                    ProgressView("Fetching Photos...")
                    Spacer()
                } else if photos.isEmpty {
                    Spacer()
                    Text("No photos found for this day.\nTry another date or rover.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(photos) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            PhotoRowView(photo: photo) // Using a new reusable row view
                        }
                    }
                }
            }
            .navigationTitle("Mars Explorer")
            .task {
                // Fetch photos when the app starts
                await loadPhotos()
            }
            .onChange(of: selectedRover) { _, _ in
                // Fetch photos whenever the rover changes
                Task { await loadPhotos() }
            }
            .onChange(of: selectedDate) { _, _ in
                // Fetch photos whenever the date changes
                Task { await loadPhotos() }
            }
        }
    }
    
    private func loadPhotos() async {
        isLoading = true
        do {
            self.photos = try await apiService.fetchPhotos(for: selectedRover, on: selectedDate, page: 1)
        } catch {
            print("Error fetching photos: \(error)")
            self.photos = []
        }
        isLoading = false
    }
}

// NEW: A reusable view for our list rows to keep code clean
struct PhotoRowView: View {
    let photo: Photo
    @EnvironmentObject var favoritesStore: FavoritesStore
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: photo.imgSrc)) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Sol: \(photo.sol)")
                    .font(.headline)
                Text(photo.camera.fullName)
                    .font(.subheadline)
            }
            
            Spacer()
            
            // The favorite button
            Button {
                favoritesStore.toggle(photo)
            } label: {
                Image(systemName: favoritesStore.contains(photo) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.title2)
            }
            .buttonStyle(.plain) // Allows the NavigationLink to still work
        }
    }
}
