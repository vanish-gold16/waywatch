//
//  LibraryItem.swift
//  waywatch
//
//  Represents single watchlist item
//
import Foundation
import SwiftData

@Model
class LibraryItem {
    var tmdbId: Int
    var type: MediaType
    var name: String
    var overview: String
    var rating: Double?
    
    /// user's given rating to  media
    var ratingGiven: Int?
    var poster: URL?
    var year: Int?
    var addedAt: Date
    
    var status: LibraryStatus
    
    init(from result: SearchResult) {
        self.tmdbId = result.tmdbId
        self.type = result.type
        self.name = result.name
        self.overview = result.description
        self.rating = result.rating
        self.poster = result.poster
        self.year = result.year
        self.addedAt = .now
        self.status = .planned
    }
}

extension LibraryItem {
    static let samples = SearchResult.samples.map { sample in
        LibraryItem(from: sample)
    }
}
