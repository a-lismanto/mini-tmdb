//
//  ContentView.swift
//  mini-tmdb
//
//  Created by Andrew HL on 7/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {

        NavigationView {
            MainView()
                .navigationBarTitle(Text("Main"))
                .navigationBarItems(
                    //leading: EditButton()
                    trailing: NavigationLink(
                        destination: FavoriteMovieView()
                    ) {
                        //Button("\(event.timestamp!, formatter: dateFormatter)")
                        Image(systemName: "heart.fill")
                    }
//                    Button(
//                        action: {
//                            withAnimation { Event.create(in: self.viewContext) }
//                        }
//                    ) {
//                        Image(systemName: "heart.fill")
//                    }
                )
            Text("Detail view content goes here")
                .navigationBarTitle(Text("Detail"))
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
//    @State var networkingManager = NetworkingManager()
//
//    var body: some View {
//        List {
//            ForEach(networkingManager.movieList.results, id: \.id) { movie in
//                VStack(alignment: .leading) {
//                    AsyncImage(
//                        url: URL(string: "https://image.tmdb.org/t/p/w92" + movie.poster_path)!,
//                        placeholder: Text("Loading ...")
//                    ).frame(minWidth:80, maxWidth: 80, minHeight: 120, maxHeight: 120).aspectRatio(contentMode: .fit)
//                    Text(movie.title)
//                }
//            }
//        }
//    }
}

//struct MasterView: View {
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Event.timestamp, ascending: true)],
//        animation: .default)
//    var events: FetchedResults<Event>
//
//    @Environment(\.managedObjectContext)
//    var viewContext
//
//    var body: some View {
//        List {
//            ForEach(events, id: \.self) { event in
//                NavigationLink(
//                    destination: DetailView(event: event)
//                ) {
//                    Text("\(event.timestamp!, formatter: dateFormatter)")
//                }
//            }.onDelete { indices in
//                self.events.delete(at: indices, from: self.viewContext)
//            }
//        }
//    }
//}

//struct DetailView: View {
//    @ObservedObject var event: Event
//
//    var body: some View {
//        Text("\(event.timestamp!, formatter: dateFormatter)")
//            .navigationBarTitle(Text("Detail"))
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
