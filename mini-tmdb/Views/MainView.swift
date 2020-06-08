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

//extension Binding {
//    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
//        return Binding(
//            get: { self.wrappedValue },
//            set: { selection in
//                self.wrappedValue = selection
//                handler(selection)
//        })
//    }
//}

//curl --request GET \
//--url 'https://api.themoviedb.org/3/movie/popular?api_key=c2bd0adf136236cb75033d37eb6111a5'
struct MainView: View {
    @State var movieFromApi: MovieApiList = MovieApiList()
    @State private var favoriteColor = 0
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.added, ascending: false)],
//        animation: .default)
//    var localMovies: FetchedResults<Movie>
    var colors = ["Popular", "Top Rated", "Now Playing"]
    
    //@Binding var notifyParentOnChangeIndex: Int
    
//    @Environment(\.managedObjectContext)
//    var viewContext
    func colorChange(_ tag: Int) {
        print("Color tag: \(tag)")
    }
    
    func loadData(selectedList: Int) {
        if (selectedList == 0) {
            //print("Load Popular")
            PopularMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
                //print(self.movieFromApi)
            }
        } else if (selectedList == 1) {
            //print("Load Top")
            TopRatedMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
                //print(self.movieFromApi)
            }
        } else if (selectedList == 2) {
            //print("Load Playing")
            NowPlayingMovieApi().getMovies { movieFromApi in
                self.movieFromApi = movieFromApi
                //print(self.movieFromApi)
            }
        }
    }
    
    var body: some View {
        let faveColor = Binding<Int>(get: {

            return self.favoriteColor

        }, set: {
            self.favoriteColor = $0
            self.loadData(selectedList: $0)

        })
        
//        var poster = ""
//        if (movie.poster_path!) {
//            poster = "https://image.tmdb.org/t/p/w92" + movie.poster_path!
//        }
        
        return VStack {
                    Picker(selection: faveColor, label: Text("What is your favorite color?")) {
                        ForEach(0..<colors.count) { index in
                            Text(self.colors[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    List {
                        ForEach(movieFromApi.results, id: \.id) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movie: movie)
                            ) {
                                MovieRow(movie: movie)
//                                Text(movie.title)
//                                    .fontWeight(.bold)
                            
//                                HStack(alignment: .center) {
//                                    AsyncImage(
//                                        url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg")!,
//                                        placeholder: Text("...")
//                                    ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
//                                    VStack(alignment: .leading) {
//                                        Text(movie.title)
//                                            .fontWeight(.bold)
//                                        Text(movie.release_date)
//                                            .font(.system(size: 14))
//                                            .foregroundColor(.gray)
//                                        Text(movie.overview)
//                                            .font(.system(size: 12))
//                                            .background(Color.red)
//                                    }.frame(minHeight: 120, maxHeight: 120)
//
//                                }
                            }
                        }
                    }
                    .onAppear {
//                        PopularMovieApi().getMovies { movieFromApi in
//                            self.movieFromApi = movieFromApi
//                            //print(self.movieFromApi)
//                        }
                        self.loadData(selectedList: self.favoriteColor)
                    }
        }
        
        
            
    }

}

struct MovieRow: View {
    var movie : MovieListEntry
    
    var body: some View {
        HStack(alignment: .center) {
//            AsyncImage(
//                url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg")!,
//                placeholder: Text("...")
//            ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
