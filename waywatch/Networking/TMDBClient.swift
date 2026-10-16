//
//  TMDBClient.swift
//  waywatch
//
//  A service for handling TMDB API responses
//
import Foundation

struct TMDBClient {
    
    // Base url for both movies and shows
    private static let commonBaseURL = URL(string: "https://api.themoviedb.org/3/search/")
    
    // Base URL for TMDB poster images; `poster_path` is relative to this
    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    // Builds a full poster URL from TMDB's relative `poster_path`
    private func posterURL(for path: String?) -> URL? {
        guard let path, let base = Self.imageBaseURL else { return nil }
        return base.appending(path: path)
    }
    
    func search(_ name: String, type: MediaType) async throws -> [SearchResult] {
        guard let base = Self.commonBaseURL else { throw URLError(.badURL) }
        
        // Full URL for movie search; TMDB expects the search term in `query`
        let url = base.appending(path: type == .movie ? "movie" : "show")
            .appending(queryItems: [URLQueryItem(name: "query", value: name)])
        
        // Building URL request
        var request = URLRequest(url: url)
        
        // Setting HTTP authorization Bearer token
        request.setValue("Bearer \(Secrets.tmdbToken)", forHTTPHeaderField: "Authorization")
        
        // Send async request
        let (data, error) = try await URLSession.shared.data(for: request)

        return try parseResponse(from: data, type: type)

    }
    
    // The item type is a compile-time generic parameter, so it can't be selected
    // with a runtime value; branch instead and let case resolve its own type
    func parseResponse(from data: Data, type: MediaType) throws -> [SearchResult] {
        // Create JSON decoder
        let decoder = JSONDecoder()
        
        // Set decoding strategy to convert "the_word" to "theWord"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        switch type {
        case .movie:
            let response = try decoder.decode(TMDBResponse<TMDBMovieItem>.self, from: data)
            return response.results.map { result in
                SearchResult(id: result.id, type: .movie, name: result.title, poster: posterURL(for: result.posterPath), description: result.overview, tmdbGenre: result.genreIds)
            }
        case .show:
            let response = try decoder.decode(TMDBResponse<TMDBShowItem>.self, from: data)
            return response.results.map { result in
                SearchResult(id: result.id, type: .show, name: result.name, poster: posterURL(for: result.posterPath), description: result.overview, tmdbGenre: result.genreIds)
            }
        }
    }
}
