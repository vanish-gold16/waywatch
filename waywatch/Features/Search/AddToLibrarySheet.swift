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
    
    @Bindable var item: WatchlistItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: Waywatch.Space.x3) {
                poster
                info
                    .foregroundStyle(P.textSecondary)
            }
            HStack {
                remove
                status
            }
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
        Menu {
            Picker("Status", selection: $item.status) {
                ForEach(WatchlistStatus.allCases, id: \.self) { status in
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
    
    @ViewBuilder
    private var remove: some View {
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

#Preview("Light") {
    VStack {
        let container = try! ModelContainer(for: WatchlistItem.self, configurations: .init(isStoredInMemoryOnly: true))
        let item = WatchlistItem(from: SearchResult.samples[0])
        container.mainContext.insert(item)
        return AddToLibrarySheet(item: item)
            .modelContainer(container)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack {
        let container = try! ModelContainer(for: WatchlistItem.self, configurations: .init(isStoredInMemoryOnly: true))
        let item = WatchlistItem(from: SearchResult.samples[0])
        container.mainContext.insert(item)
        return AddToLibrarySheet(item: item)
            .modelContainer(container)
    }
    .preferredColorScheme(.dark)
}
