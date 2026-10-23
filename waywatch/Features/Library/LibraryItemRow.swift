//
//  LibraryItemRow.swift
//  waywatch
//
//  Represents item stored in library
//
import SwiftUI

struct LibraryItemView: View {
    
    private typealias P = Waywatch.Palette
    
    var item: LibraryItem
    
    var body: some View {
        poster
            .overlay(alignment: .topTrailing) {
                ratingGiven
            }
    }
    
    /// poster eleemnt as an AsyncImage or plain image
    @ViewBuilder
    private var poster: some View {
        AsyncImage(url: item.poster) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            RoundedRectangle(cornerRadius: Waywatch.Radius.md)
                .fill(P.surfaceSecondary)
                .overlay {
                    Image(systemName: "questionmark")
                }
        }
        .frame(width: 144, height: 216)
        .clipShape(.rect(cornerRadius: Waywatch.Radius.sm))
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
    var ratedItem: LibraryItem = {
        let item = LibraryItem(from: SearchResult(tmdbId: 67, type: .movie, name: "Rated Item", poster: nil, description: "Just rated item sample", year: 2026, rating: 6.7, tmdbGenre: [1, 2, 3]))
        item.ratingGiven = 10
        return item
    } ()
    VStack {
        LibraryItemView(item: ratedItem)
        ForEach (LibraryItem.samples) { sample in
            LibraryItemView(item: sample)
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    var ratedItem: LibraryItem = {
        let item = LibraryItem(from: SearchResult(tmdbId: 67, type: .movie, name: "Rated Item", poster: nil, description: "Just rated item sample", year: 2026, rating: 6.7, tmdbGenre: [1, 2, 3]))
        item.ratingGiven = 10
        return item
    }()
    VStack {
        LibraryItemView(item: ratedItem)
        ForEach (LibraryItem.samples) { sample in
            LibraryItemView(item: sample)
        }
    }
    .preferredColorScheme(.dark)
}
