//
//  SettingsView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var titleOn: Bool
        
    @State private var notificationsEnabled = false
    @State private var selectedTheme = 0
    @State private var fontSize: Double = 16
    
    @Environment(\.colorScheme) var colorScheme
    
    //для задания 4
    @AppStorage("rowHeight") private var rowHeight: Double = 60
    @State private var isChangingHeight = false
    
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
                    
                    //задание1
                    Text(colorScheme == .dark ? "Dark Theme Enabled" : "Light Theme enabled")
                        .foregroundStyle(.secondary)
                }
                Section(header: Text("Список фильмов")) {
                    Toggle("Показывать заголовок списка", isOn: $titleOn)
                    
                    if titleOn {
                        Text("Navigation title enabled")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section(header: Text("Высота строки списка")) {
                    Text("Выберите высоту строки для отображения фильмов в списке")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    Slider(
                        value: $rowHeight,
                        in: 40...100,
                        step: 5,
                        onEditingChanged: { editing in
                            isChangingHeight = editing
                        }
                    )
                    
                    Text("Текущая высота: \(Int(rowHeight))")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    if isChangingHeight {
                        InfoRow(
                            post: Post(
                                id: -1,
                                title: "Пример строки",
                                description: "",
                                imageURL: ""
                            ),
                            rowHeight: rowHeight
                        )
                        .transition(.opacity)
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
            .animation(.easeInOut, value: isChangingHeight)
            .navigationTitle("Настройки")
        }
    }
    
}
