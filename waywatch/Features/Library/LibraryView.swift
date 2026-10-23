//
//  LibraryView.swift
//  waywatch
//
//  Represents user's library with all statuses
//
import SwiftData
import SwiftUI

struct LibraryView: View {
    
    @Query(sort: \WatchlistItem.addedAt, order: .reverse) private var items: [WatchlistItem]
    
    var body: some View {
        
    }
    
}

#Preview("Light") {
    VStack {
        LibraryView()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack {
        LibraryView()
    }
    .preferredColorScheme(.dark)
}
