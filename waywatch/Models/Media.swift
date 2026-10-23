//
//  Media.swift
//  waywatch
//
//  Unites enums for media
//
import SwiftUI

enum MediaType: String, Codable {
    case movie = "movie"
    case show = "show"
}

/// Represents each status of watchlist item can be in
enum LibraryStatus: String, Codable, CaseIterable {
    case planned = "planned"
    case progress = "progress"
    case completed = "completed"
    case onHold = "onHold"
    case dropped = "dropped"
    case notAdded = "notAdded"
}

extension LibraryStatus {
    var title: String {
        switch self {
        case .planned:
            return "Planned"
        case .progress:
            return "In Progress"
        case .completed:
            return "Completed"
        case .onHold:
            return "On hold"
        case .dropped:
            return "Dropped"
        case .notAdded:
            return "Not added"
        }
    }
}

extension LibraryStatus {
    var icon: String {
        switch self {
        case .planned:
            return "bookmark"
        case .progress:
            return "play.circle"
        case .completed:
            return "checkmark.circle"
        case .onHold:
            return "pause.circle"
        case .dropped:
            return "xmark.circle"
        case .notAdded:
            return "plus"
        }
    }
}

extension LibraryStatus {
    var color: Color {
        switch self {
        case .planned:
            return Waywatch.Palette.statusPlanned
        case .progress:
            return Waywatch.Palette.statusProgress
        case .completed:
            return Waywatch.Palette.statusCompleted
        case .onHold:
            return Waywatch.Palette.statusOnHold
        case .dropped:
            return Waywatch.Palette.statusDropped
        case .notAdded:
            return Waywatch.Palette.primary
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
