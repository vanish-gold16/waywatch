//
//  SearchResultRow.swift
//  waywatch
//
//  Represents single search result
//
import SwiftUI

struct SearchResultRow: View {
    
    let result: SearchResult
    
    var body: some View {
        HStack {
            Text(result.name)
                .foregroundStyle(Waywatch.Palette.textPrimary)
        }
    }
    
}

#Preview("Light") {
    ForEach(SearchResult.samples, id: \.id) { sample in
        SearchResultRow(result: sample)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ForEach(SearchResult.samples, id: \.id) { sample in
        SearchResultRow(result: sample)
    }
    .preferredColorScheme(.dark)
}
