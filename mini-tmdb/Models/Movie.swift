//
//  Movie.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//


import SwiftUI
import CoreData

extension Movie {
    static func create(in managedObjectContext: NSManagedObjectContext, movie: MovieListEntry){
        let newMovie = self.init(context: managedObjectContext)
        newMovie.id = Int32(movie.id)
        newMovie.title = movie.title
        newMovie.release_date = movie.release_date
        newMovie.overview = movie.overview
        newMovie.title = movie.title
        newMovie.poster_path = movie.poster_path
        newMovie.added = Date()
        
        print(newMovie);
        
        do {
            try  managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            print(nserror.localizedDescription)
        }
    }
}

extension Collection where Element == Movie, Index == Int {
    func delete(index: Int, from managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.delete(self[index])
 
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            print(nserror.localizedDescription)
        }
    }
}
