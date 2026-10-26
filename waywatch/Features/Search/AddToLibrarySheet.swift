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
    
    @Bindable var item: LibraryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: Waywatch.Space.x3) {
                Components.composeLibraryPoster(item)
                Components.composeLibraryInfo(item)
                    .foregroundStyle(P.textSecondary)
            }
            HStack {
                Components.composeRemove(item, modelContext: modelContext, dismiss: dismiss)
                Components.composeStatus(item)
            }
        }
        .padding(Waywatch.Space.x3)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

#Preview("Light") {
    VStack {
        let container = try! ModelContainer(for: LibraryItem.self, configurations: .init(isStoredInMemoryOnly: true))
        let item = LibraryItem(from: SearchResult.samples[0])
        container.mainContext.insert(item)
        return AddToLibrarySheet(item: item)
            .modelContainer(container)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack {
        let container = try! ModelContainer(for: LibraryItem.self, configurations: .init(isStoredInMemoryOnly: true))
        let item = LibraryItem(from: SearchResult.samples[0])
        container.mainContext.insert(item)
        return AddToLibrarySheet(item: item)
            .modelContainer(container)
    }
    .preferredColorScheme(.dark)
}
