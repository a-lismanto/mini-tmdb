//
//  ReviewApiList.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation
import SwiftUI

struct ReviewApiList : Decodable {
    var results: [ReviewListEntry] = []
}

struct ReviewListEntry : Decodable, Hashable {
    var author: String
    var id: String
    var content: String
    var url: String
//    var overview: String
//    var release_date: String
}

class MovieReviewApi {
    func getReview(movieId: String, completion: @escaping (ReviewApiList) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/" + movieId + "/reviews?api_key=c2bd0adf136236cb75033d37eb6111a5"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            let reviewList = try! JSONDecoder().decode(ReviewApiList.self, from: data)

            DispatchQueue.main.async {
                completion(reviewList)
            }
        }.resume()
    }
}
