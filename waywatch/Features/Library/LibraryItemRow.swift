//
//  LibraryItemRow.swift
//  waywatch
//
//  Represents item stored in library
//
import SwiftUI

struct LibraryItemRow: View {
    
    private typealias P = Waywatch.Palette
    
    var item: LibraryItem
    
    var body: some View {
        VStack {
            Components.composeLibraryPoster(item)
                .overlay(alignment: .topTrailing) {
                    ratingGiven
                }
        }
    }
    
    @ViewBuilder
    private var ratingGiven: some View {
        if let ratingGiven = item.ratingGiven {
            Text(ratingGiven.description)
                .font(.system(size: 22, weight: .black, design: .rounded))
                .bold()
                .foregroundStyle(P.rating)
                .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: .capsule) // или .black.opacity(0.7)
        }
    }
    
}

#Preview("Light") {
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var ratedItem: LibraryItem = {
        let item = LibraryItem(from: SearchResult(tmdbId: 67, type: .movie, name: "Rated Item", poster: nil, description: "Just rated item sample", year: 2026, rating: 6.7, tmdbGenre: [1, 2, 3]))
        item.ratingGiven = 10
        return item
    } ()
    ScrollView {
        LazyVGrid(columns: columns) {
            LibraryItemRow(item: ratedItem)
            ForEach (LibraryItem.samples) { sample in
                LibraryItemRow(item: sample)
            }
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var ratedItem: LibraryItem = {
        let item = LibraryItem(from: SearchResult(tmdbId: 67, type: .movie, name: "Rated Item", poster: nil, description: "Just rated item sample", year: 2026, rating: 6.7, tmdbGenre: [1, 2, 3]))
        item.ratingGiven = 10
        return item
    }()
    ScrollView {
        LazyVGrid(columns: columns) {
            LibraryItemRow(item: ratedItem)
            ForEach (LibraryItem.samples) { sample in
                LibraryItemRow(item: sample)
            }
        }
    }
    .preferredColorScheme(.dark)
}
