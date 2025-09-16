//
//  FavoritesView.swift
//  MarsExplorer
//
//  Created by aniruddha yadav on 16/09/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesStore: FavoritesStore

    var body: some View {
        NavigationStack {
            VStack {
                if favoritesStore.photos.isEmpty {
                    Spacer()
                    Text("No Favorites Yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Tap the star on any photo to save it here.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(favoritesStore.photos) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            PhotoRowView(photo: photo)
                        }
                    }
                }
            }
            .navigationTitle("Favorite Photos")
        }
    }
}
