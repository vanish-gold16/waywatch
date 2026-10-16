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

                movies.append(contentsOf: try await client.searchMovies("dune"))
                movies.append(contentsOf: try await client.searchShows("breaking bad"))
                movies.append(contentsOf: try await client.searchMovies("qweuf"))
                print(movies.map(\.name))
            } catch {
                print(error)
            }
        }
}
