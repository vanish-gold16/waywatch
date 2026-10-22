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
    case planned, processing, completed, onHold, dropped
}

extension WatchlistStatus {
    var icon: String {
        switch self {
        case .planned:
            return "bookmark"
        case .processing:
            return "play.circle"
        case .completed:
            return "checkmark.circle"
        case .onHold:
            return "pause.circle"
        case .dropped:
            return "xmark.circle"
        }
    }
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
