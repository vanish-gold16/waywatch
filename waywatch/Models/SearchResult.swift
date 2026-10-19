//
//  SearchResult.swift
//  waywatch
//
//  gathers many API responses in it (can be TMDB, MyAnimeList etc.)
//
import Foundation

struct SearchResult {
    let id: Int
    let type: MediaType
    let name: String
    let poster: URL?
    let description: String
    let year: Int?
    let rating: Double
    
    /// TMDB genre IDs
    let tmdbGenre: [Int]?
}

extension SearchResult {
    static let samples = [
        SearchResult(id: 1, type: .movie, name: "Fight Club", poster: nil, description: "My favourite movie", tmdbGenre: [1, 2, 3]),
        SearchResult(id: 2, type: .movie, name: "Amelie", poster: nil, description: "Vibeeeee", tmdbGenre: [2, 4]),
        SearchResult(id: 3, type: .show, name: "Breaking Bad", poster: nil, description: "Absolute cinema", tmdbGenre: [1, 3, 8])
    ]
}
