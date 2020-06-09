//
//  MovieApiList.swift
//  mini-tmdb
//
//  Created by Andrew HL on 7/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieApiList : Decodable {
    var results: [MovieListEntry] = []
}

struct MovieListEntry : Decodable, Hashable {
    var title: String
    var id: Int
    var poster_path: String?
    var overview: String
    var release_date: String
}

class PopularMovieApi {
    func getMovies(completion: @escaping (MovieApiList) -> ()) {
        guard let url = URL(string: Constants.BuildMovieListURL(listCategories: .popular)) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            var movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)
            movieList.results.forEach { (movie) in
                let index = movieList.results.firstIndex(of: movie)!
                movieList.results[index].release_date = DateHelper.DateStringFormatChange(tmdbDateString: movie.release_date)
            }

            DispatchQueue.main.async {
                completion(movieList)
            }
        }.resume()
    }
}

class TopRatedMovieApi {
    func getMovies(completion: @escaping (MovieApiList) -> ()) {
        guard let url = URL(string: Constants.BuildMovieListURL(listCategories: .topRated)) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            var movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)
            movieList.results.forEach { (movie) in
                let index = movieList.results.firstIndex(of: movie)!
                movieList.results[index].release_date = DateHelper.DateStringFormatChange(tmdbDateString: movie.release_date)
            }

            DispatchQueue.main.async {
                completion(movieList)
            }
        }.resume()
    }
}

class NowPlayingMovieApi {
    func getMovies(completion: @escaping (MovieApiList) -> ()) {
        guard let url = URL(string: Constants.BuildMovieListURL(listCategories: .nowPlaying)) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            var movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)
            movieList.results.forEach { (movie) in
                let index = movieList.results.firstIndex(of: movie)!
                movieList.results[index].release_date = DateHelper.DateStringFormatChange(tmdbDateString: movie.release_date)
            }
            
            DispatchQueue.main.async {
                completion(movieList)
            }
        }.resume()
    }
}
