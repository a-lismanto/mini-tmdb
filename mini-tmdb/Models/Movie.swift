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
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
//    static func remove(in managedObjectContext: NSManagedObjectContext, movie: MovieListEntry) {
//        print("try delete " + movie.title)
//        ForEach(self.movies) { index in
////            if () {
////
////            }
//            let localMovie = self.movies[index];
//            print("movie " + localMovie.)
//        }
//    }
}

extension Collection where Element == Movie, Index == Int {
    func delete(index: Int, from managedObjectContext: NSManagedObjectContext) {
        //indices.forEach { managedObjectContext.delete(self[$0]) }
//        print(managedObjectContext);
        managedObjectContext.delete(self[index])
 
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
