//
//  NetworkingManager.swift
//  mini-tmdb
//
//  Created by Andrew HL on 7/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager : ObservableObject {
    var didChange = PassthroughSubject<NetworkingManager, Never>()
    
    var movieList = MovieApiList(results: []) {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c2bd0adf136236cb75033d37eb6111a5") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            let movieList = try! JSONDecoder().decode(MovieApiList.self, from: data)

            DispatchQueue.main.async {
                self.movieList = movieList
            }
        }.resume()
    }
    
}
