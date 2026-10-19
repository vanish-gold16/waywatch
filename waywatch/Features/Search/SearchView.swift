//
//  MovieSearchView.swift
//  waywatch
//
//  Represents element of found movies with search bar
//
import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var found: [SearchResult] = []
    
    var body: some View {
        NavigationStack {
            List(found, id: \.name) { element in
                Text(element.name)
            }
            .navigationTitle("Search")
            .searchable(text: $query)
            .onSubmit(of: .search) {
                Task {
                    do {
                        found = try await TMDBClient().search(query, type: .movie)
                    } catch {
                        print(error)
                    }
                }
            }
        }
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
