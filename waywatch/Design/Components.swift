//
//  Components.swift
//  waywatch
//
//  Common UI components used in several places
//
import SwiftData
import SwiftUI

struct Components {
    
    private typealias P = Waywatch.Palette
    
    /// Builds poster for library using LibraryItem
    @ViewBuilder
    static func composeLibraryPoster(_ item: LibraryItem) -> some View {
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
    
    /// Poster eleemnt as an AsyncImage or plain image for SearchResultRow
    @ViewBuilder
    static func composeResultsPoster(_ result: SearchResult) -> some View {
        AsyncImage(url: result.poster) { image in
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
        .frame(width: 72, height: 108)
        .clipShape(.rect(cornerRadius: Waywatch.Radius.sm))
    }
    
    /// Main body with whole info about media for Library
    @ViewBuilder
    static func composeLibraryInfo(_ item: LibraryItem) -> some View {
        VStack(alignment: .leading, spacing: Waywatch.Space.x1) {
            Text(item.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundStyle(P.textPrimary)
            
            // Meta row
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
            Text(item.overview)
                .font(.footnote)
                .lineLimit(8)
        }
    }
    /// Main body with whole info about media for results
    @ViewBuilder
    static func composeResultInfo(_ result: SearchResult) -> some View {
        VStack(alignment: .leading, spacing: Waywatch.Space.x1) {
            Text(result.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundStyle(P.textPrimary)
            HStack {
                Text(result.type.title)
                if let year = result.year {
                    Text(String(year))
                }
                if let rating = result.rating {
                    Label(rating.formatted(.number.precision(.fractionLength(1))), systemImage: "star.fill")
                        .foregroundStyle(P.rating)
                }
            }
            .font(.subheadline)
            .foregroundStyle(P.textSecondary)
            Text(result.description)
                .font(.footnote)
                .lineLimit(3)
        }
    }
    
    /// Button for switching media status
    @ViewBuilder
    static func composeStatus(_ item: LibraryItem) -> some View {
        @Bindable var item = item
        Menu {
            Picker("Status", selection: $item.status) {
                ForEach(LibraryStatus.allCases, id: \.self) { status in
                    Label(status.title, systemImage: status.icon)
                        .tag(status)
                }
            }
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
        .id(item.status)
    }
    
    /// Builds remove button
    @ViewBuilder
    static func composeRemove(_ item: LibraryItem, modelContext: ModelContext, dismiss: DismissAction) -> some View {
        Button {
            modelContext.delete(item)
            dismiss()
        } label: {
            Image(systemName: "trash")
        }
        .buttonStyle(.glassProminent)
        .tint(P.statusDropped)
    }
    
}
