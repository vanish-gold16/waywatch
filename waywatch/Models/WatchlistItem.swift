//
//  WatchlistItem.swift
//  waywatch
//
//  Represents single watchlist item
//
import Foundation
import SwiftData

@Model
class WatchlistItem {
    var tmdbId: Int
    var type: MediaType
    var name: String
    var poster: URL?
    var year: Int?
    var addedAt: Date
    
    init(from result: SearchResult) {
        self.tmdbId = result.tmdbId
        self.type = result.type
        self.name = result.name
        self.poster = result.poster
        self.year = result.year
        self.addedAt = .now
    }
}
