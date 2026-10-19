//
//  SearchView.swift
//  waywatch
//
//  Represents element of found movies with search bar
//
import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var state: SearchState = .idle
    
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
                                    SearchResultRow(result: found)
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
                        let found = try await TMDBClient().search(query, type: .movie)
                        state = .loaded(found)
                    } catch {
                        state = .failed(error.localizedDescription)
                    }
                }
            }
            
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
