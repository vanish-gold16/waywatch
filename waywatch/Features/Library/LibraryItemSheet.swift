//
//  LibraryItemSheet.swift
//  waywatch
//
//  Represents full view if a library item stored
//
import SwiftUI

struct LibraryItemSheet: View {
    
    private typealias P = Waywatch.Palette
    
    var item: LibraryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: Waywatch.Space.x3) {
                Components.composeLibraryPoster(item)
                Components.composeLibraryInfo(item)
                    .foregroundStyle(P.textSecondary)
            }
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

#Preview("Light") {
    LibraryItemSheet(item: LibraryItem.samples.first!)
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    LibraryItemSheet(item: LibraryItem.samples.first!)
        .preferredColorScheme(.dark)
}
