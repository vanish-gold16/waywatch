//
//  SavedRowView.swift
//  waywatch
//
//  Created by Vanya on 19.10.2026.
//
import SwiftData
import SwiftUI

struct SaveRowView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    private typealias P = Waywatch.Palette
    
    let result: SearchResult
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: Waywatch.Space.x3) {
                poster
                info
                    .foregroundStyle(P.textSecondary)
                Spacer()

            }
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(P.surface, in: .rect(cornerRadius: Waywatch.Radius.lg))
    }
    
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
        .frame(width: 144, height: 216)
        .clipShape(.rect(cornerRadius: Waywatch.Radius.sm))
    }
    
    /// Main body with whole info about media
    @ViewBuilder
    private var info: some View {
        VStack(alignment: .leading, spacing: Waywatch.Space.x1) {
            Text(result.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundStyle(P.textPrimary)
            metaRow
            Text(result.description)
                .font(.footnote)
                .lineLimit(8)
        }
    }
    
    /// additional info about media
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
    
}

#Preview("Light") {
    ScrollView {
        SaveRowView(result: SearchResult.samples.first!)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        SaveRowView(result: SearchResult.samples.first!)
    }
    .preferredColorScheme(.dark)
}
