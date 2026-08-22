//
//  ContentView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InfoView()
                .tabItem {
                    Label("Фильмы", systemImage: "film")
                }
            HelloView()
                .tabItem {
                    Label("Hello", systemImage: "hand.wave")
                }
            
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
