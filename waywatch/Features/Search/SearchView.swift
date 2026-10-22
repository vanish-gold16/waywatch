//
//  SearchView.swift
//  waywatch
//
//  Represents element of found movies with search bar
//
import SwiftData
import SwiftUI

struct SearchView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [WatchlistItem]
    
    @State private var query = ""
    @State private var state: SearchState = .idle
    
    @State private var adding: WatchlistItem?
    
    var body: some View {
        NavigationStack {
            Group {
                switch state {
                case .idle:
                    ContentUnavailableView("Explore", systemImage: "magnifyingglass")
                case .loading:
                    Text("Loading")
                case .loaded(let founds):
                    if founds.isEmpty {
                        ContentUnavailableView.search(text: query)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: Waywatch.Space.x3) {
                                ForEach(founds) { found in
                                    SearchResultRow(result: found) {
                                        findOrAdd(from: found)
                                    }
                                }
                            }
                            .padding(.horizontal, Waywatch.Space.x4)
                        }
                    }
                case .failed(let message):
                    ContentUnavailableView("Something went wrong", systemImage: "exclamationmark.triangle",
                                           description: Text(message))
                }
            }
            .navigationTitle("Search")
            .searchable(text: $query)
            .onSubmit(of: .search) {
                Task {
                    do {
                        state = .loading
                        let found = try await TMDBClient().searchAll(name: query)
                        state = .loaded(found)
                    } catch {
                        state = .failed(error.localizedDescription)
                    }
                }
            }
            .sheet(item: $adding) { result in
                AddToLibrarySheet(item: result)
            }
        }
    }
    
    private func findOrAdd(from result: SearchResult) {
        if let existing = items.first(where: { $0.tmdbId == result.tmdbId && $0.type == result.type }) {
            adding = existing
        } else {
            let item = WatchlistItem(from: result)
            modelContext.insert(item)
            adding = item
        }
    }
    
    enum SearchState {
        case idle, loading
        case loaded([SearchResult])
        case failed(String)
    }
    
}

#Preview("Light") {
    SearchView()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    SearchView()
        .preferredColorScheme(.dark)
}
