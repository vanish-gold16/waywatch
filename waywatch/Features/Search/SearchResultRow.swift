//
//  SearchResultRow.swift
//  waywatch
//
//  Represents single search result
//
import SwiftUI

struct SearchResultRow: View {
    
    let result: SearchResult
    
    private typealias P = Waywatch.Palette
    
    var body: some View {
        HStack(alignment: .top, spacing: Waywatch.Space.x3) {
            poster
            info
                .foregroundStyle(P.textSecondary)
            Spacer()
            addButton
                .frame(maxHeight: .infinity) // центрирует кнопку по вертикали
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(P.surface, in: .rect(cornerRadius: Waywatch.Radius.lg))
        .overlay {
            RoundedRectangle(cornerRadius: Waywatch.Radius.lg)
                .strokeBorder(P.separator)
        }
    }
    
    // poster eleemnt as an AsyncImage or plain image
    @ViewBuilder
    private var poster: some View {
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
    
    // Main body with whole info about media
    @ViewBuilder
    private var info: some View {
        VStack(alignment: .leading, spacing: Waywatch.Space.x1) {
            Text(result.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundStyle(P.textSecondary)
            metaRow
            Text(result.description)
                .font(.footnote)
                .lineLimit(3)
        }
    }
    
    @ViewBuilder
    private var metaRow: some View {
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
    }
    
    @ViewBuilder
    private var addButton: some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(P.onPrimary)
        }
        .tint(P.primary)
        .buttonStyle(.glassProminent)
    }
    
}

#Preview("Light") {
    ScrollView {
        ForEach(SearchResult.samples, id: \.id) { sample in
            VStack(spacing: Waywatch.Space.x3) {
                SearchResultRow(result: sample)
            }
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        ForEach(SearchResult.samples, id: \.id) { sample in
            SearchResultRow(result: sample)
        }
    }
    .preferredColorScheme(.dark)
}
