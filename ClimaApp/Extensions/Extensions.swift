//
//  Extensions.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 11/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation


extension Date {
    
    func shortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: self)
    }
    
    func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}


extension String {
    //MARK: - remove accents
       func toNoSmartQuotes() -> String {
           let userInput: String = self
           return userInput.folding(options: .diacriticInsensitive, locale: .current)
       }
}
