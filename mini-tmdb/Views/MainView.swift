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
    var colors = ["Popular", "Top Rated", "Now Playing"]
    
    //@Binding var notifyParentOnChangeIndex: Int
    
//    @Environment(\.managedObjectContext)
//    var viewContext
    func colorChange(_ tag: Int) {
        print("Color tag: \(tag)")
    }
    
    var body: some View {
        let faveColor = Binding<Int>(get: {

            return self.favoriteColor

        }, set: {

            

            // TODO: DO YOUR STUFF HERE
            // TODO: DO YOUR STUFF HERE
            // TODO: DO YOUR STUFF HERE
            //print(self.colors[$0]);
            self.favoriteColor = $0
            if ($0 == 0) {
                print("Load Popular")
                PopularMovieApi().getMovies { movieFromApi in
                    self.movieFromApi = movieFromApi
                    //print(self.movieFromApi)
                }
            } else if ($0 == 1) {
                print("Load Top")
                TopRatedMovieApi().getMovies { movieFromApi in
                    self.movieFromApi = movieFromApi
                    //print(self.movieFromApi)
                }
            } else if ($0 == 2) {
                print("Load Playing")
                NowPlayingMovieApi().getMovies { movieFromApi in
                    self.movieFromApi = movieFromApi
                    //print(self.movieFromApi)
                }
            }

            // USE this if needed to notify parent
            //self.notifyParentOnChangeIndex = $0

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
                    //List(movieFromApi.results) { movie in
                    List {
                        ForEach(movieFromApi.results, id: \.id) { movie in
                            HStack(alignment: .center) {
                                AsyncImage(
                                    url: URL(string: movie.poster_path != nil ? "https://image.tmdb.org/t/p/w92" + movie.poster_path! : "https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-4ee37443c461fff5bc221b43ae018a5dae317469c8e2479a87d562537dd45fdc.svg")!,
                                    placeholder: Text("...")
                                ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                    Text(movie.release_date)
                                }
                            }
                        }
                    }
                    .onAppear {
                        PopularMovieApi().getMovies { movieFromApi in
                            self.movieFromApi = movieFromApi
                            //print(self.movieFromApi)
                        }
                    }
        }
        
        
            
    }
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Event.timestamp, ascending: true)],
//        animation: .default)
//    var events: FetchedResults<Event>
//
//    @Environment(\.managedObjectContext)
//    var viewContext
//
//    var body: some View {
//            List {
//                ForEach(events, id: \.self) { event in
//                    HStack(alignment: .center) {
//                        AsyncImage(
//                            url: URL(string: "https://image.tmdb.org/t/p/w92/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg")!,
//                            placeholder: Text("Loading ...")
//                        ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
//                        VStack(alignment: .leading) {
//                            Text("MovieTitle")
//                            Text("\(event.timestamp!, formatter: dateFormatter)")
//                        }
//                    }
//                }.onDelete { indices in
//                    self.events.delete(at: indices, from: self.viewContext)
//                }
//            }
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
