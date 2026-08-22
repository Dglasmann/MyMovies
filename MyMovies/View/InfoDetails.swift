//
//  InfoDetails.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct InfoDetails: View {
    var post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: post.imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Color.gray.opacity(0.3)
                            .overlay(Image(systemName: "photo").foregroundColor(.gray))
                    default:
                        Color.gray.opacity(0.3)
                            .overlay(ProgressView())
                    }
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
                
                Text(post.title)
                    .font(.largeTitle)
                    .bold()
                
                Text (post.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
