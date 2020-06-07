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

//curl --request GET \
//--url 'https://api.themoviedb.org/3/movie/popular?api_key=c2bd0adf136236cb75033d37eb6111a5'
struct MainView: View {
    @State var movieFromApi: MovieApiList = MovieApiList()

//    @Environment(\.managedObjectContext)
//    var viewContext
    
    var body: some View {
        List(movieFromApi.results) { movie in
//            Text(movie.title)
//            Text(movie.release_date)
            HStack(alignment: .center) {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w92" + movie.poster_path)!,
                    placeholder: Text("...")
                ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(movie.title)
                    Text(movie.release_date)
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
