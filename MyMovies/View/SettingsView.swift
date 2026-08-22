//
//  SettingsView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = false
    @State private var selectedTheme = 0
    @State private var fontSize: Double = 16
    
    let themes = ["Светлая", "Тёмная", "Системная"]
    
    var body: some View {
        NavigationView() {
            Form {
                Section(header: Text("Общие")) {
                    Toggle("Уведомления", isOn: $notificationsEnabled)
                    
                    Picker("Тема оформления", selection: $selectedTheme) {
                        ForEach(0..<themes.count, id: \.self) { index in
                            Text(themes[index])
                        }
                    }
                }
                Section(header: Text("Внешний вид")) {
                    VStack(alignment: .leading) {
                        Text("Размер шрифта: \(Int(fontSize))")
                        Slider(value: $fontSize, in: 12...24, step: 1)
                    }
                }
                Section(header: Text("О приложении")) {
                    Text("Версия 1.0")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Настройки")
        }
    }
    
}
