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
//    
//    @ViewBuilder
//    private var ratingGiven: some View {
//        if item.
//    }
    
}

#Preview("Light") {
    VStack {
        ForEach (LibraryItem.samples) { sample in
            LibraryItemView(item: sample)
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack {
        ForEach (LibraryItem.samples) { sample in
            LibraryItemView(item: sample)
        }
    }
    .preferredColorScheme(.dark)
}
