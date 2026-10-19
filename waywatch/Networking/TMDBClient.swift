//
//  TMDBClient.swift
//  waywatch
//
//  A service for handling TMDB API responses
//
import Foundation

struct TMDBClient {
    
    /// Base url for both movies and shows
    private static let commonBaseURL = URL(string: "https://api.themoviedb.org/3/search/")
    
    /// Base URL for TMDB poster images; `poster_path` is relative to this
    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    /// Builds a full poster URL from TMDB's relative `poster_path`
    private func posterURL(for path: String?) -> URL? {
        guard let path, let base = Self.imageBaseURL else { return nil }
        return base.appending(path: path)
    }
    
    func searchAll(name: String) async throws -> [SearchResult] {
        async let movies = search(name, type: .movie)
        async let shows = search(name, type: .show)
        
        // Read each `async let` once, with `try`, then interleave the results
        let (movieResults, showResults) = try await (movies, shows)

        var all: [SearchResult] = []

        // Mix movies' and shows' results
        for i in 0..<max(movieResults.count, showResults.count) {
            if i < movieResults.count { all.append(movieResults[i]) }
            if i < showResults.count { all.append(showResults[i]) }
        }
        
        return all
    }
    
    func search(_ name: String, type: MediaType) async throws -> [SearchResult] {
        guard let base = Self.commonBaseURL else { throw URLError(.badURL) }
        
        // Full URL for movie search; TMDB expects the search term in `query`
        let url = base.appending(path: type == .movie ? "movie" : "tv")
            .appending(queryItems: [URLQueryItem(name: "query", value: name)])
        
        // Building URL request
        var request = URLRequest(url: url)
        
        // Setting HTTP authorization Bearer token
        request.setValue("Bearer \(Secrets.tmdbToken)", forHTTPHeaderField: "Authorization")
        
        // Send async request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Guarding http response not to have any errors
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard http.statusCode == 200 else {
            throw TMDBResponseError.badStatus(http.statusCode)
        }

        return try parseResponse(from: data, type: type)

    }
    
    /// The item type is a compile-time generic parameter, so it can't be selected
    /// with a runtime value; branch instead and let case resolve its own type
    func parseResponse(from data: Data, type: MediaType) throws -> [SearchResult] {
        // Create JSON decoder
        let decoder = JSONDecoder()
        
        // Set decoding strategy to convert "the_word" to "theWord"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        switch type {
        case .movie:
            let response = try decoder.decode(TMDBResponse<TMDBMovieItem>.self, from: data)
            return response.results.map { result in
                SearchResult(tmdbId: result.id, type: .movie, name: result.title, poster: posterURL(for: result.posterPath), description: result.overview, year: toYear(result.releaseDate), rating: result.voteAverage == 0 ? nil : result.voteAverage, tmdbGenre: result.genreIds)
            }
        case .show:
            let response = try decoder.decode(TMDBResponse<TMDBShowItem>.self, from: data)
            return response.results.map { result in
                SearchResult(tmdbId: result.id, type: .show, name: result.name, poster: posterURL(for: result.posterPath), description: result.overview, year: toYear(result.firstAirDate), rating: result.voteAverage == 0 ? nil : result.voteAverage, tmdbGenre: result.genreIds)
            }
        }
    }
    
    /// TMDB dates look like "1999-10-15"; the year is the part before the first dash
    private func toYear(_ date: String) -> Int? {
        return date.split(separator: "-").first.flatMap { Int($0) }
    }
    
}
