//
//  mini_tmdbTests.swift
//  mini-tmdbTests
//
//  Created by Andrew HL on 7/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import XCTest
import CoreData
@testable import mini_tmdb

class mini_tmdbTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUrlBuilder() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let popularUrl = Constants.BuildMovieListURL(listCategories: .popular)
        XCTAssert(popularUrl == "https://api.themoviedb.org/3/movie/popular?api_key=c2bd0adf136236cb75033d37eb6111a5")
        let topRatedUrl = Constants.BuildMovieListURL(listCategories: .topRated)
        XCTAssert(topRatedUrl == "https://api.themoviedb.org/3/movie/top_rated?api_key=c2bd0adf136236cb75033d37eb6111a5")
        let nowPlayingUrl = Constants.BuildMovieListURL(listCategories: .nowPlaying)
        XCTAssert(nowPlayingUrl == "https://api.themoviedb.org/3/movie/now_playing?api_key=c2bd0adf136236cb75033d37eb6111a5")
        let movieReviewUrl = Constants.BuildMovieReviewURL(movieId: "12345")
        XCTAssert(movieReviewUrl == "https://api.themoviedb.org/3/movie/12345/reviews?api_key=c2bd0adf136236cb75033d37eb6111a5")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
