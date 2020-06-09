//
//  MovieReviewRow.swift
//  mini-tmdb
//
//  Created by Andrew HL on 8/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import SwiftUI

struct ReviewRow: View {
    var review: ReviewListEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.author)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Text(review.content)
                .font(.system(size: 14))
                
        }
    }
}
