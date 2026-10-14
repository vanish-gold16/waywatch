//
//  TMDBAnswerItem.swift
//  waywatch
//
//  Revieved answer from TMDB, contains both movie and TV-shows fields
//

struct TMDBAnswerItem: Decodable {
    let adult: Bool
    
    /// can be null
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    
    /// TV shows only
    let originCountry: [String]?
    
    /// Movies only
    let title: String?
    let originalLanguage: String
    
    /// Shows
    let originalName: String?
    
    /// Movies
    let originalTitle: String?
    let overview: String
    let popularity: Double
    
    /// can be null
    let posterPath: String?
    
    /// Movies
    let releaseDate: String?
    
    /// Shows
    let firstAirDate: String?
    let softCore: Bool
    
    let voteAverage: Double
    let voteCount: Int
}
