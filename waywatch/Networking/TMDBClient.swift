//
//  TMDBClient.swift
//  waywatch
//
//  A service for handling TMDB API responses
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

    func parseMovieResponse(from data: Data) throws -> [SearchResult] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(TMDBResponse<TMDBMovieItem>.self, from: data)
        return response.results.map { result in
            SearchResult(id: result.id, type: .movie, name: result.title, poster: posterURL(for: result.posterPath), description: result.overview, tmdbGenre: result.genreIds)
        }
    }
    
}

//
//#Playground {
//    let json = #"""
//        {
//            "page": 1,
//            "results": [
//                {
//                    "adult": false,
//                    "backdrop_path": "/",
//                    "genre_ids": [1, 67],
//                    "id": 1,
//                    "title": "JewJewtsu Kaisen",
//                    "original_language": "ja",
//                    "original_title": "I don't have japanese keyboard",
//                    "overview": "An anime",
//                    "poster_path": "wayoni.com/place/prague",
//                    "release_date": "1067-06-07",
//                    "vote_average": 6.7,
//                    "vote_count": 67
//                }
//            ],
//            "total_pages": 1,
//            "total_results": 1
//        }
//        """#
//
//    let client = TMDBClient()
//    do {
//        let movies = try client.parseMovieResponse(from: Data(json.utf8))
//        print(movies.map(\.name))
//    } catch {
//        print(error)
//    }
//}
