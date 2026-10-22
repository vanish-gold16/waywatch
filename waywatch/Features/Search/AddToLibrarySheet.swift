//
//  AddToLibrarySheet.swift
//  waywatch
//
//  A modal for adding media to the library
//
import SwiftData
import SwiftUI

struct AddToLibrarySheet: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private typealias P = Waywatch.Palette
    
    let item: WatchlistItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: Waywatch.Space.x3) {
                poster
                info
                    .foregroundStyle(P.textSecondary)
            }
            status
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
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
    
    /// Main body with whole info about media
    @ViewBuilder
    private var info: some View {
        VStack(alignment: .leading, spacing: Waywatch.Space.x1) {
            Text(item.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundStyle(P.textPrimary)
            metaRow
            Text(item.overview)
                .font(.footnote)
                .lineLimit(8)
        }
    }
    
    /// additional info about media
    @ViewBuilder
    private var metaRow: some View {
        HStack {
            Text(item.type.title)
            if let year = item.year {
                Text(String(year))
            }
            if let rating = item.rating {
                Label(rating.formatted(.number.precision(.fractionLength(1))), systemImage: "star.fill")
                    .foregroundStyle(P.rating)
            }
        }
        .font(.subheadline)
        .foregroundStyle(P.textSecondary)
    }
    
    /// button for switching media status
    @ViewBuilder
    private var status: some View {
        Button {
            
        } label: {
            HStack {
                Text(item.status.title)
                Image(systemName: item.status.icon)
                Divider()
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption)
            }
            .fixedSize()
        }
        .buttonStyle(.glassProminent)
        .tint(item.status.color)
    }
    
}

#Preview("Light") {
    ScrollView {
        AddToLibrarySheet(item: WatchlistItem(from: SearchResult.samples.first!))
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        AddToLibrarySheet(item: WatchlistItem(from: SearchResult.samples.first!))
    }
    .preferredColorScheme(.dark)
}
