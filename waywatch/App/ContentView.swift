import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

#Preview {
    ContentView()
        .task {
            do {
                let client = TMDBClient()
                var movies: [SearchResult] = []

                movies.append(contentsOf: try await client.search("dune", type: .movie))
                movies.append(contentsOf: try await client.search("breaking bad", type: .show))
                movies.append(contentsOf: try await client.search("qweuf", type: .movie))
                print(movies.map(\.name))
            } catch {
                print(error)
            }
        }
}
