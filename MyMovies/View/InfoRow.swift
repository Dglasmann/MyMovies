//
//  InfoRow.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct InfoRow: View {
    var post: Post
    var rowHeight: Double = 60
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: post.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                        .foregroundStyle(.gray)
                default:
                    Color.gray.opacity(0.6)
                }
            }
            .clipShape(Circle())
            .frame(width: rowHeight, height: rowHeight)
            .padding(.trailing, 8)
            
            Text(post.title)
                .font(.headline)
                .lineLimit(1)
            
            Spacer()
        }
        .padding(.vertical, 4)
        .frame(minHeight: rowHeight)
    }
}
