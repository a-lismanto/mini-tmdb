//
//  FavoriteMovieDetailView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//


import SwiftUI
import SDWebImageSwiftUI

struct FavoriteMovieDetailView: View {
    var movie: Movie
    @State var reviewFromApi: ReviewApiList = ReviewApiList()
//
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
        animation: .default)
    var localMovies: FetchedResults<Movie>
    @State var isFavorite = true
    @State var localIndex = -1
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    func getLocalIndex() {
        self.localMovies.forEach { localMovie in
            if localMovie.id == Int32(self.movie.id) {
                self.localIndex = self.localMovies.firstIndex(of: localMovie)!
            }
        }
    }
    
    func toggleFavorite() {
        localMovies.delete(index: localIndex, from: self.viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        print(isFavorite);
        var imgName = "heart"
        if isFavorite {
            imgName = "heart.fill"
        }
//        let localIndex = getLocalMovieIndex()
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
                        Text(movie.release_date ?? "")
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
                    Text(movie.overview ?? "")
                        .font(.system(size: 12))
                    
                }
            }
            List {
                Text("Reviews")
                    .fontWeight(.bold)
                ForEach(reviewFromApi.results, id: \.id) { review in
                    //Text("Comment goes here")
                    ReviewRow(review: review)
                }
            }
            .onAppear {
                MovieReviewApi().getReview(movieId: String(self.movie.id), completion: { reviewFromApi in
                    self.reviewFromApi = reviewFromApi
                    self.getLocalIndex()
                })
            }
        }
        .navigationBarTitle(movie.title ?? "")
    }
}
