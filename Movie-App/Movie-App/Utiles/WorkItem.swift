//
//  WorkItem.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//


import Foundation

///  SearchBar'ın textDidChange methodunu her harf girişinde değil de, kullanıcı yazmayı bıraktığında tetiklemek için kullandığımız class.
class WorkItem {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)
        
        pendingRequestWorkItem = requestWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
