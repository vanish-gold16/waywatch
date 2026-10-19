//
//  TMDBMovieItem.swift
//  waywatch
//
//  Revieved answer for movie from TMDB, contains movie fields only
//

struct TMDBMovieItem: Decodable {
    /// adult content
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    
    /// Displayed name
    let title: String
    
    /// Local
    let originalLanguage: String
    let originalTitle: String
    
    /// Movie description
    let overview: String
    let posterPath: String?
    
    /// formate `2023-09-29`
    let releaseDate: String
    
    let voteAverage: Double
    let voteCount: Int
}

extension TMDBMovieItem {
    static let sample = TMDBMovieItem(adult: false, backdropPath: "/", genreIds: [1, 67], id: 1, title: "JewJewtsu Kaisen", originalLanguage: "ja", originalTitle: "I don't have japanese keyboard", overview: "An anime", posterPath: "/jewjewtsu-kaisen.jpg", releaseDate: "1967-06-07", voteAverage: 6.7, voteCount: 67)
}
