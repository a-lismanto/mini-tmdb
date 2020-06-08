//
//  MovieDetailView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: MovieListEntry
    @State var reviewFromApi: ReviewApiList = ReviewApiList()
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
//        animation: .default)
    var localMovies: FetchedResults<Movie>
//    @State var isFavorite = false
//    @State var localIndex = -1
    
//    func isFavorite() {
//
//    }
    
    func toggleFavorite() {
        print("doSomething")
    }
    
    func getLocalMovieIndex() -> Int {
        var result = -1;
        
//        var found = false
//        var foundIndex = -1
        self.localMovies.forEach { (localMovie) in
            if (localMovie.id == Int32(self.movie.id)) {
//                found = true
                result = self.localMovies.firstIndex(of: localMovie)!
            }
        }
//        self.isFavorite = found
//        self.localIndex = foundIndex
        
        return result;
    }

    var body: some View {
//        print(isFavorite);
//        var imgName = "heart"
//        if isFavorite {
//            imgName = "heart.fill"
//        }
//        var imgName = "heart"
//        if isFavorite {
//            imgName = "heart.fill"
//        }
        let localIndex = getLocalMovieIndex()
        var poster = "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg"
        if movie.poster_path != nil {
            poster = "https://image.tmdb.org/t/p/w92" + movie.poster_path!
        }
        print(poster, localIndex);
        
        return VStack(alignment: .leading) {
            //MovieDetailRow(movie: movie, isFavorite: isFavorite, localIndex: localIndex, localMovies: movies)
            HStack(alignment: .top) {
                AsyncImage(
                    url: URL(string: poster)!,
                    placeholder: Text("...")
                ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
                VStack(alignment: .center) {
                    HStack(alignment: .top) {
                        Text(movie.release_date)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
    //                        print("tapped")
    //                        Movie.create(in: self.viewContext, movie: self.movie)
                            self.toggleFavorite()
                        }) {
                            Image(systemName: "heart")
                                .frame(minWidth:40, maxWidth: 40, minHeight: 20, maxHeight: 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Text(movie.overview)
                        .font(.system(size: 12))
                        .background(Color.red)
                    
                }
            }
            List {
                Text("Reviews")
                    .fontWeight(.bold)
                ForEach(reviewFromApi.results, id: \.id) { review in
                    //Text("Comment goes here")
                    ReviewRow(review: review)
                }


            }.onAppear {
                MovieReviewApi().getReview(movieId: String(self.movie.id), completion: { reviewFromApi in
                    self.reviewFromApi = reviewFromApi
                })
            }
            
        }
        .navigationBarTitle(movie.title)
    }
}

struct MovieDetailRow: View {
    @Environment(\.managedObjectContext)
    var viewContext
    var movie : MovieListEntry
    var isFavorite: Bool
    var localIndex: Int
    var localMovies: FetchedResults<Movie>
    
    func toggleFavorite() {
        // do something here
        if isFavorite {
            // remove
            localMovies.delete(index: localIndex, from: viewContext)
//            self.localMovies.forEach { (localMovie) in
//                if (localMovie.id == Int32(self.movie.id)) {
//                    //localMovies.delete(index: <#T##Int#>, from: <#T##NSManagedObjectContext#>)
//                }
//            }
        } else {
            // add to favorite
            Movie.create(in: self.viewContext, movie: self.movie)
        }
//        self.isFavorite = !self.isFavorite
    }
    
    var body: some View {
        var imgName = "heart"
        if isFavorite {
            imgName = "heart.fill"
        }
        var poster = "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg"
        if movie.poster_path != nil {
            poster = "https://image.tmdb.org/t/p/w92" + movie.poster_path!
        }
        print(isFavorite, poster)
        return HStack(alignment: .top) {
            AsyncImage(
                url: URL(string: poster)!,
                placeholder: Text("...")
            ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Text(movie.release_date)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
//                        print("tapped")
//                        Movie.create(in: self.viewContext, movie: self.movie)
                        self.toggleFavorite()
                    }) {
                        Image(systemName: imgName)
                            .frame(minWidth:40, maxWidth: 40, minHeight: 20, maxHeight: 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Text(movie.overview)
                    .font(.system(size: 12))
                    .background(Color.red)
                
            }
            //.buttonStyle(PlainButtonStyle())

        }
    }
}

struct ReviewRow: View {
    var review: ReviewListEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.author)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Text(review.content)
                .font(.system(size: 14))
                
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
