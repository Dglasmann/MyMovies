//
//  ContentView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = InfoViewModel()
    @StateObject private var quizStore = QuizStore()
    
    @AppStorage("titleOn") private var titleOn: Bool = true
    @AppStorage("rowHeight") private var rowHeight: Double = 60
    
    
    var body: some View {
        TabView {
            InfoView(viewModel: viewModel, quizStore: quizStore, titleOn: titleOn, rowHeight: rowHeight)
                .tabItem {
                    Label("Фильмы", systemImage: "film")
                }
            MovieQuizView(viewModel: viewModel, quizStore: quizStore)
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
