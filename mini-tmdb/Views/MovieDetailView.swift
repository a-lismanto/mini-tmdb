//
//  MovieDetailView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    var movie: MovieListEntry
    @State var reviewFromApi: ReviewApiList = ReviewApiList()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
        animation: .default)
    var localMovies: FetchedResults<Movie>
    @State var isFavorite = false
    @State var localIndex = -1
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    func checkIsFavorite() {
        self.localMovies.forEach { localMovie in
            if localMovie.id == Int32(self.movie.id) {
                self.isFavorite = true
                self.localIndex = self.localMovies.firstIndex(of: localMovie)!
            }
        }
    }
    
    func toggleFavorite() {
        if isFavorite {
                    // remove
            localMovies.delete(index: localIndex, from: self.viewContext)
        } else {
            // add to favorite
            Movie.create(in: self.viewContext, movie: self.movie)
        }
        self.isFavorite = !self.isFavorite
    }
    
    var body: some View {
        print(isFavorite);
        var imgName = "heart"
        if isFavorite {
            imgName = "heart.fill"
        }

        var poster = "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg"
        if movie.poster_path != nil {
            poster = "https://image.tmdb.org/t/p/w92" + movie.poster_path!
        }
        
        return VStack(alignment: .leading) {
            HStack(alignment: .top) {
                WebImage(url: URL(string: poster))
                    .frame(width: 80, height: 140, alignment: .center)
                VStack(alignment: .center) {
                    HStack(alignment: .top) {
                        Text(movie.release_date)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            self.toggleFavorite()
                        }) {
                            Image(systemName: imgName)
                                .frame(minWidth:40, maxWidth: 40, minHeight: 20, maxHeight: 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Text(movie.overview)
                        .font(.system(size: 12))
                    
                }
                .padding(.leading, 4)
            }
            .padding(8)
            List {
                Text("Reviews")
                    .fontWeight(.bold)
                ForEach(reviewFromApi.results, id: \.id) { review in
                    ReviewRow(review: review)
                }
            }.onAppear {
                MovieReviewApi().getReview(movieId: String(self.movie.id), completion: { reviewFromApi in
                    self.reviewFromApi = reviewFromApi
                    self.checkIsFavorite()
                })
            }
        }
        .navigationBarTitle(movie.title)
    }
}
