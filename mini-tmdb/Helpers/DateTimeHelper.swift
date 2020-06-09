//
//  DateTimeHelper.swift
//  mini-tmdb
//
//  Created by Andrew HL on 9/6/20.
//  Copyright © 2020 AHLISM. All rights reserved.
//

import Foundation

struct DateHelper {
    static func DateStringFormatChange(tmdbDateString: String) -> String {
        let tmdbDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }()
    
        let appDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            return dateFormatter
        }()
        
        let date = tmdbDateFormatter.date(from: tmdbDateString)!
        let stringDate = appDateFormatter.string(from: date)
        
        return stringDate;
        
    }
}
