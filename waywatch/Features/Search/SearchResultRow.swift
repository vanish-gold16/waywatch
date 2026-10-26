//
//  SearchResultRow.swift
//  waywatch
//
//  Represents single search result
//
import SwiftUI

struct SearchResultRow: View {
    
    let result: SearchResult
    
    /// called when the user taps the add button
    let onAdd: () -> Void
    let status: LibraryStatus?
    
    private typealias P = Waywatch.Palette
    
    var body: some View {
        HStack(alignment: .top, spacing: Waywatch.Space.x3) {
            Components.composeResultsPoster(result)
            Components.composeResultInfo(result)
                .foregroundStyle(P.textSecondary)
            Spacer()
            addButton
                .frame(maxHeight: .infinity) // centers button at vertical
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(P.surface, in: .rect(cornerRadius: Waywatch.Radius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: Waywatch.Radius.lg)
                .strokeBorder(P.separator)
        }
    }
    
    @ViewBuilder
    private var addButton: some View {
        Button {
            onAdd()
        } label: {
            Image(systemName: status?.icon ?? "plus")
                .foregroundStyle(P.onPrimary)
        }
        .tint(status?.color ?? P.primary)
        .buttonStyle(.glassProminent)
    }
    
}

#Preview("Light") {
    ScrollView {
        ForEach(SearchResult.samples) { sample in
            VStack(spacing: Waywatch.Space.x3) {
                SearchResultRow(result: sample, onAdd: {}, status: .planned)
            }
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        ForEach(SearchResult.samples) { sample in
            SearchResultRow(result: sample, onAdd: {}, status: .notAdded)
        }
    }
    .preferredColorScheme(.dark)
}
