// This is the final version of SplashScreenView.swift with a black theme and stylized name

import SwiftUI

struct SplashScreenView: View {
    @State private var scale = 0.7
    @State private var opacity = 0.5
    
    let developerName = "Aniruddha"
    
    var body: some View {
        ZStack {
            // UPDATED: A solid black background
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "globe.americas.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                Text("MarsExplorer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("Made by \(developerName)")
                        // UPDATED: Stylish font for your name
                        .font(.system(.caption, design: .serif))
                        .italic()
                        .foregroundColor(.white) // Changed to pure white
                        .padding([.trailing, .bottom])
                }
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.5)) {
                    self.scale = 1.0
                    self.opacity = 1.0
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
