//
//  FavoriteMovieView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct FavoriteMovieView: View {
//    var movie: MovieListEntry
//    @State var reviewFromApi: ReviewApiList = ReviewApiList()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
        animation: .default)
    var movies: FetchedResults<Movie>
    
    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(
                        destination: FavoriteMovieDetailView(movie: movie)
                    ) {
                        FavoriteMovieRow(movie: movie)
                    }
//                    FavoriteMovieRow(movie: movie)
                }
                .onDelete { indices in
                    var idx = -1;
                    indices.forEach { idx = $0 }
                    //print(self.movies[idx].id)
                    //let collectionIndex =
                    
                    self.movies.delete(index: idx, from: self.viewContext)
                }
            }
            
//            .onAppear {
//                MovieReviewApi().getReview(movieId: String(self.movie.id), completion: { reviewFromApi in
//                    self.reviewFromApi = reviewFromApi
//                })
//                @FetchRequest(
//                    entity: Movie.entity,
//                    sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
//                    animation: .default)
//                self.movies: FetchedResults<Movie>
//            }
        }
        .navigationBarTitle(Text("Favorite"))
    }
}


struct FavoriteMovieRow: View {
    var movie : Movie
    
    var body: some View {
        HStack(alignment: .center) {
//            AsyncImage(
//                url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg")!,
//                placeholder: Text("...")
//            ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
            WebImage(url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg"))
                .frame(width: 80, height: 140, alignment: .center)
            VStack(alignment: .leading) {
                Text(movie.title!)
                    .fontWeight(.bold)
                Text(movie.release_date!)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Text(movie.overview!)
                    .font(.system(size: 12))
            }
            .padding(.leading, 4)
            .frame(minHeight: 120, maxHeight: 140)

        }
    }
}
