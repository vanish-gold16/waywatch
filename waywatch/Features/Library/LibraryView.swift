//
//  LibraryView.swift
//  waywatch
//
//  Represents user's library with all statuses
//
import SwiftData
import SwiftUI

struct LibraryView: View {
    
    @Query(sort: \LibraryItem.addedAt, order: .reverse) private var items: [LibraryItem]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    @State private var onFull: LibraryItem?
    
    var body: some View {
        if items.isEmpty {
            ContentUnavailableView("Your library is empty", image: "magnifyingglass", description: Text("Try searching media"))
        }
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(items) { item in
                    LibraryItemRow(item: item)
                        .onTapGesture {
                            onFull = item
                        }
                }
            }
        }
        .sheet(item: $onFull) { item in
            LibraryItemSheet(item: item)
        }
    }
    
}

#Preview("Light") {
    VStack {
        LibraryView()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack {
        LibraryView()
    }
    .preferredColorScheme(.dark)
}
