//
//  Show.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//


struct Show: Codable {
    let id: Int
    let name: String
    let summary: String?
    let image: ShowImage?
}

struct ShowImage: Codable {
    let medium: String
    let original: String
}
