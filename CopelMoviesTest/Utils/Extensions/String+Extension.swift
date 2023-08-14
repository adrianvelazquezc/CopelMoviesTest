//
//  String+Extension.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

public func getLabelText(text: String, font: UIFont = .systemFont(ofSize: 15, weight: .bold)) -> NSMutableAttributedString {
    let multipleAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1),
        NSAttributedString.Key.font: font
    ]
    let attributedString = NSMutableAttributedString(string: text, attributes: multipleAttributes)
    
    return attributedString
}

public func parseDate(_ str : String, oldDateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = oldDateFormat
    
    let date = dateFormatter.date(from: str) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}
