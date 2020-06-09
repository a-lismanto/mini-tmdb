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
                .navigationBarTitle(Text("Movie List"))
                .navigationBarItems(
                    trailing: NavigationLink(
                        destination: FavoriteMovieView()
                    ) {
                        Text("My Favorite")
                    }
                )
//            Text("Detail view content goes here")
//                .navigationBarTitle(Text("Detail"))
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
