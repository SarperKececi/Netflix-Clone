//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 14.02.2024.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError {
        case error
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadItem(model: Title , completion: @escaping (Result<Void, Error>) -> Void) {
       
        let context = AppDelegate.shared.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.media_type = model.media_type
        item.id = Int64(model.id)
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        item.overview = model.overview
      
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(DatabaseError.error)
        }
    }
    
    func fetchingDataFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        let context = AppDelegate.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(error))
        }
    }
    func deleteItem(titleItem: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = AppDelegate.shared.persistentContainer.viewContext
        context.delete(titleItem)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    
}
