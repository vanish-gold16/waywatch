//
//  Media.swift
//  waywatch
//
//  Created by Vanya on 14.10.2026.
//

enum MediaType: Codable {
    case movie
    case show
}

/// Represents each status of watchlist item can be in
enum WatchlistStatus: Codable {
    case planned, watching, completed, onHold, dropped
}

extension MediaType {
    var title: String {
        switch self {
        case .movie:
            return "film"
        case .show:
            return "show"
        }
    }
}
