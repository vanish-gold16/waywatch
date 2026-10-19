//
//  Media.swift
//  waywatch
//
//  Created by Vanya on 14.10.2026.
//

enum MediaType {
    case movie
    case show
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
