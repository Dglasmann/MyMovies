//
//  MovieQuizView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 29.08.2026.
//

import SwiftUI
import UIKit

struct MovieQuizView: View {
    @ObservedObject var viewModel: InfoViewModel
    @ObservedObject var quizStore: QuizStore
    
    @State private var correctPost: Post?
    @State private var options: [Post] = []
    @State private var score = 0
    @State private var selectedOptionID: Int?
    @State private var isCorrectAnswer: Bool?
    @State private var feedbackScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if viewModel.posts.count < 3 {
                    ProgressView("Загружаем базу знаний...")
                        .padding()
                } else if let correctPost {
                    scoreHeader
                    
                    Text("Угадайте фильм по описанию")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text(correctPost.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.thinMaterial)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .scaleEffect(feedbackScale)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: feedbackScale)
                    
                    VStack(spacing: 12) {
                        ForEach(options) { option in
                            optionButton(for: option)
                        }
                    }
                    .padding(.horizontal)
                    
                    if let isCorrectAnswer {
                        Text(isCorrectAnswer ? "Правильно! 🎉" : "Неверно, попробуйте еще раз")
                            .font(.subheadline.bold())
                            .foregroundStyle(isCorrectAnswer ? .green : .red)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    
                    Spacer()
                } else {
                    
                    ProgressView()
                }
            }
            .padding(.top)
            .navigationTitle("Викторина")
            .onAppear {
                if correctPost == nil {
                    newQuestion()
                }
            }
        }
    }
    
    private var scoreHeader: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text("Счёт: \(score)")
                .font(.subheadline.bold())
            Spacer()
            Text("Изучено: \(quizStore.learnedPosts.count)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    
    private func optionButton(for option: Post) -> some View {
        Button {
            select(option)
        } label: {
            Text (option.title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor(for: option))
        }
    }
    
    private func backgroundColor(for option: Post) -> Color {
            guard let selectedOptionID, selectedOptionID == option.id else {
                return Color.gray.opacity(0.15)
            }
            return (isCorrectAnswer == true) ? Color.green.opacity(0.3) : Color.red.opacity(0.3)
        }
    
    private func newQuestion() {
        guard viewModel.posts.count >= 3 else { return }
        
        let shuffled = viewModel.posts.shuffled()
        let correct = shuffled[0]
        let distractors = Array(shuffled.dropFirst().prefix(2))
        
        correctPost = correct
        options = (distractors + [correct]).shuffled()
        selectedOptionID = nil
        isCorrectAnswer = nil
    }
    
    private func select(_ option: Post) {
        guard let correctPost else { return }
        selectedOptionID = option.id
        let correct = option.id == correctPost.id
        isCorrectAnswer = correct
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(correct ? .success : .error)
        
        if correct {
            score += 1
            withAnimation { feedbackScale = 1.05 }
            quizStore.markLearned(correctPost)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    feedbackScale = 1.0
                    newQuestion()
                }
            }
        }
    }
}
