//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 3.02.2024.
//

import Foundation
extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}
