import SwiftUI

@main
struct MarsBrowserApp: App {
    // Create the FavoritesStore once and keep it alive for the whole app
    @StateObject private var favoritesStore = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            // Launch the MainView and make the favoritesStore available to all child views
            MainView()
                .environmentObject(favoritesStore)
        }
    }
}
