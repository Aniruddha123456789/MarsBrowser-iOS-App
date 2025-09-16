//
//  MapView.swift
//  MarsExplorer
//
//  Created by aniruddha yadav on 16/09/25.
//

// This is the code for the new file: MapView.swift

import SwiftUI
import MapKit

// This struct defines a location on our Mars map
struct MarsLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    
    // The map will be centered around the coordinate with a specific zoom level
    @State private var region: MKCoordinateRegion
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    // The single pin that shows the rover's location
    private var locations: [MarsLocation] {
        [MarsLocation(coordinate: coordinate)]
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
    }
}
