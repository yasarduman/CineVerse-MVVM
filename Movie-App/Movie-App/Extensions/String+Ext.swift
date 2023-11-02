//
//  String+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
