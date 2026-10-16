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
    
    /// TMDB genre IDs
    let tmdbGenre: [Int]?
}
