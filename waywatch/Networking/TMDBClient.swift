//
//  TMDBClient.swift
//  waywatch
//
//  A service for handling TMDB API
//
import Foundation
import Playgrounds

struct TMDBClient {

    /// Base URL for TMDB poster images; `poster_path` is relative to this
    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")

    /// Builds a full poster URL from TMDB's relative `poster_path`
    private func posterURL(for path: String?) -> URL? {
        guard let path, let base = Self.imageBaseURL else { return nil }
        return base.appending(path: path)
    }

    func parseMovieResponse(from data: Data) throws -> SearchResult {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let movie = try decoder.decode(TMDBMovieItem.self, from: data)
            return SearchResult(id: movie.id, type: .movie, name: movie.title, poster: posterURL(for: movie.posterPath), description: movie.overview, tmdbGenre: movie.genreIds)
        } catch {
            throw error
        }
    }
    
}

#Playground {
    let json = #"""
        {
            "adult": false,
            "backdrop_path": "/",
            "genre_ids": [1, 67],
            "id": 1,
            "title": "JewJewtsu Kaisen",
            "original_language": "ja",
            "original_title": "I don't have japanese keyboard",
            "overview": "An anime",
            "poster_path": "wayoni.com/place/prague",
            "release_date": "1067-06-07",
            "vote_average": 6.7,
            "vote_count": 67
        }
        """#
    
    let client = TMDBClient()
    do {
        let movie = try client.parseMovieResponse(from: Data(json.utf8))
        print(movie.name)
    } catch {
        print(error)
    }
}
