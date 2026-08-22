//
//  Post.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let imageURL: String
}
