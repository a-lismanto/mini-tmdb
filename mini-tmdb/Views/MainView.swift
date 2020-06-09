//
//  MainView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 7/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import SDWebImageSwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct MainView: View {
    @State var movieFromApi: MovieApiList = MovieApiList()
    @State private var categoryList = 0

    var categories = ["Popular", "Top Rated", "Now Playing"]
    
    func loadData(selectedList: Int) {
        if (selectedList == 0) {
            PopularMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
            }
        } else if (selectedList == 1) {
            TopRatedMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
            }
        } else if (selectedList == 2) {
            NowPlayingMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
            }
        }
    }
    
    var body: some View {
        let selectedCategory = Binding<Int>(get: {
            return self.categoryList
        }, set: {
            self.categoryList = $0
            self.loadData(selectedList: $0)

        })
        
        return VStack {
                    Picker(selection: selectedCategory, label: Text("What is your favorite color?")) {
                        ForEach(0..<categories.count) { index in
                            Text(self.categories[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    List {
                        ForEach(movieFromApi.results, id: \.id) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movie: movie)
                            ) {
                                MovieRow(movie: movie)
                            }
                        }
                    }
                    .onAppear {
                        self.loadData(selectedList: self.categoryList)
                    }
        }
        
        
            
    }

}

struct MovieRow: View {
    var movie : MovieListEntry
    
    var body: some View {
        HStack(alignment: .center) {
            WebImage(url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg"))
                .frame(width: 80, height: 140, alignment: .center)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .fontWeight(.bold)
                Text(movie.release_date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Text(movie.overview)
                    .font(.system(size: 12))
            }
            .padding(.leading, 4)
            .frame(minHeight: 140, maxHeight: 140)

        }
    }
}
