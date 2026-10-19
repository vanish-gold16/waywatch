//
//  TMDBShowItem.swift
//  waywatch
//
//  Revieved answer for show from TMDB, contains show fields only
//

struct TMDBShowItem: Decodable {
    // adult content
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    
    // Local
    let originCountry: [String]
    let originalName: String
    
    // Show description
    let overview: String
    let posterPath: String?
    
    // formate `2023-09-29`
    let firstAirDate: String
    
    // Displayed name
    let name: String
    
    let voteAverage: Double
    let voteCount: Int
}

extension TMDBShowItem {
    static let sample = TMDBShowItem(adult: true, backdropPath: nil, genreIds: [69], id: 69, originCountry: ["JP"], originalName: "Okaasan No Hentai", overview: "Strange video tape created in the 90th", posterPath: nil, firstAirDate: "1996-06-07", name: "I found mother's hentai", voteAverage: 9.9, voteCount: 100000)
}
