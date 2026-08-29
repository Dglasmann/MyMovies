//
//  ContentView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("titleOn") private var titleOn: Bool = true
    @AppStorage("rowHeight") private var rowHeight: Double = 60
    
    
    var body: some View {
        TabView {
            InfoView(titleOn: titleOn, rowHeight: rowHeight)
                .tabItem {
                    Label("Фильмы", systemImage: "film")
                }
            HelloView()
                .tabItem {
                    Label("Hello", systemImage: "hand.wave")
                }
            
            SettingsView(titleOn: $titleOn)
                .tabItem {
                    Label("Настройки", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
