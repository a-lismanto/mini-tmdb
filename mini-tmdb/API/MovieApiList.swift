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
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c2bd0adf136236cb75033d37eb6111a5") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            let movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)

            DispatchQueue.main.async {
                completion(movieList)
            }
        }.resume()
    }
}

class TopRatedMovieApi {
    func getMovies(completion: @escaping (MovieApiList) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=c2bd0adf136236cb75033d37eb6111a5") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            let movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)

            DispatchQueue.main.async {
                completion(movieList)
            }
        }.resume()
    }
}

class NowPlayingMovieApi {
    func getMovies(completion: @escaping (MovieApiList) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=c2bd0adf136236cb75033d37eb6111a5") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            let movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)

//            for movie in movieList.results {
//                let poster = movie.poster_path != nil ? movie.poster_path! : ""
//                print(movie.title + " poster: " + poster)
//            }
            
            DispatchQueue.main.async {
                //print(movieList.results[16].poster_path == nil)
                //ForEach(movieList.results) { movie in
//                ForEach(movieList.results, id: \.id) { movie in
//                    print(movie.title + " poster: " + movie.poster_path);
//                }
                completion(movieList)
            }
        }.resume()
    }
}
