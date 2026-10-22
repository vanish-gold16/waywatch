//
//  Media.swift
//  waywatch
//
//  Created by Vanya on 14.10.2026.
//
import SwiftUI

enum MediaType: Codable {
    case movie
    case show
}

/// Represents each status of watchlist item can be in
enum WatchlistStatus: Codable {
    case planned, processing, completed, onHold, dropped
}

extension WatchlistStatus {
    var title: String {
        switch self {
        case .planned:
            return "Planned"
        case .processing:
            return "Processing"
        case .completed:
            return "Completed"
        case .onHold:
            return "On hold"
        case .dropped:
            return "Dropped"
        }
    }
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

extension WatchlistStatus {
    var color: Color {
        switch self {
        case .planned:
            return Waywatch.Palette.statusPlanned
        case .processing:
            return Waywatch.Palette.statusProcessing
        case .completed:
            return Waywatch.Palette.statusCompleted
        case .onHold:
            return Waywatch.Palette.statusOnHold
        case .dropped:
            return Waywatch.Palette.statusDropped
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
