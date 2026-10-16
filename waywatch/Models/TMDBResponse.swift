//
//  TMDBResponse.swift
//  waywatch
//
//  A response from TMDB in formate
//   {
//      "page": 1,
//      "results": [],
//      "total_pages": 1,
//      "total_results": 2
//   }
//

struct TMDBResponse<Item: Decodable>: Decodable {
    let page: Int
    let results: [Item]
    let totalPages: Int
    let totalResults: Int
}
