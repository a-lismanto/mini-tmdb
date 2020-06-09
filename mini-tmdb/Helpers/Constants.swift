//
//  Constants.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation

struct Constants {
    static var API_KEY = "c2bd0adf136236cb75033d37eb6111a5"
    
    static var TMDB_API_V3_BASE_URL = "https://api.themoviedb.org/3"
    static var TMDB_API_MOVIE_POPULAR = "/movie/popular"
    static var TMDB_API_MOVIE_TOP_RATED = "/movie/top_rated"
    static var TMDB_API_MOVIE_NOW_PLAYING = "/movie/now_playing"
    static var TMDB_API_MOVIE = "/movie"
    static var TMDB_API_REVIEW = "/reviews"
    
    enum MovieListCategory {
        case popular, topRated, nowPlaying
    }
    
    static func BuildMovieListURL(listCategories: MovieListCategory) -> String {
        switch listCategories {
        case .topRated:
            return TMDB_API_V3_BASE_URL + TMDB_API_MOVIE_TOP_RATED + "?api_key=" + API_KEY
        case .nowPlaying:
            return TMDB_API_V3_BASE_URL + TMDB_API_MOVIE_NOW_PLAYING + "?api_key=" + API_KEY
        default:
            return TMDB_API_V3_BASE_URL + TMDB_API_MOVIE_POPULAR + "?api_key=" + API_KEY
        }
    }
    
    static func BuildMovieReviewURL(movieId: String) -> String {
        return TMDB_API_V3_BASE_URL + TMDB_API_MOVIE + "/" + movieId + TMDB_API_REVIEW + "?api_key=" + API_KEY
    }
}
