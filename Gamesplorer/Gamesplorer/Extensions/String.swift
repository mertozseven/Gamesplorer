//
//  String.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 25.05.2024.
//

import Foundation

extension String {
    
    // MARK: - Date Formatting Method
    func formattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else { return "Unknown" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM, yyyy"
        
        let day = Calendar.current.component(.day, from: date)
        let daySuffix: String
        
        switch day {
        case 11, 12, 13:
            daySuffix = "th"
        default:
            switch day % 10 {
            case 1:
                daySuffix = "st"
            case 2:
                daySuffix = "nd"
            case 3:
                daySuffix = "rd"
            default:
                daySuffix = "th"
            }
        }
        
        outputFormatter.dateFormat = "d'\(daySuffix) of' MMM, yyyy"
        
        return outputFormatter.string(from: date)
    }
    
}
