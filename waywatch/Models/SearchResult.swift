//
//  SearchResult.swift
//  waywatch
//
//  gathers many API responses in it (can be TMDB, MyAnimeList etc.)
//
import Foundation

struct SearchResult: Identifiable {
    let tmdbId: Int
    
    let type: MediaType
    let name: String
    let poster: URL?
    let description: String
    let year: Int?
    let rating: Double?
    
    /// TMDB genre IDs
    let tmdbGenre: [Int]?
    
    /// computed property is here not to mistaken movie and show if they have the same id (very possible with TMDB)
    /// now in formate "movie-125"/"show-125"
    var id: String { "\(type)-\(tmdbId)" }
}

extension SearchResult {
    static let samples = [
        SearchResult(tmdbId: 1, type: .movie, name: "Fight Club", poster: nil, description: "My favourite movie", year: 1999, rating: 8.4, tmdbGenre: [1, 2, 3]),
        SearchResult(tmdbId: 2, type: .movie, name: "Amelie", poster: nil, description: "Vibeeeee", year: 2001, rating: 7.9, tmdbGenre: [2, 4]),
        SearchResult(tmdbId: 3, type: .show, name: "Breaking Bad", poster: nil, description: "Absolute cinema", year: 2008, rating: 8.9, tmdbGenre: [1, 3, 8])
    ]
}
