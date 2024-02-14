//
//  AppDelegate.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit
import CoreData

// AppDelegate, uygulamanın yaşam döngüsü olaylarına ve Core Data entegrasyonuna yanıt veren başlıca sınıftır.

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
   static let shared = AppDelegate()

    // Uygulama başlatıldığında çağrılan fonksiyon.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Uygulama başlatıldı.")
        return true
    }

    // UISceneSession oluşturulduğunda çağrılan fonksiyon.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Yeni bir sahne oturumu oluşturulurken kullanılacak konfigürasyonu seçme.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // Sahne oturumları atıldığında çağrılan fonksiyon.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Kullanıcı bir sahne oturumunu atarsa.
        // Uygulama çalışmıyorken atılan oturumlar varsa, bu, application:didFinishLaunchingWithOptions'den kısa bir süre sonra çağrılır.
        // Atılan sahnelerle ilgili özel kaynakları serbest bırakmak için kullanılır.
    }

    // Core Data ile ilgili özellikleri ve işlevselliği sağlayan temel bir NSPersistentContainer'ı oluşturan bir özellik.
    lazy var persistentContainer: NSPersistentContainer = {
        // "NetflixCloneDataModel" adlı Core Data veri modelini yükleyen bir NSPersistentContainer örneği oluşturulur.
        let container = NSPersistentContainer(name: "NetflixCloneDataModel")
        
        // Veritabanı yüklenirken olası hataları ele alır.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Hata kontrolü ve uygulamayı çökertme (fatalError) eğer bir hata olursa.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Core Data'da yapılan değişiklikleri kaydetmek için kullanılan fonksiyon.
    func saveContext () {
        // Veritabanındaki değişiklikleri kaydetmek için bir context alınır.
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                // Değişiklikleri kaydetme işlemi gerçekleştirilir.
                try context.save()
            } catch {
                // Hata kontrolü ve uygulamayı çökertme (fatalError) eğer bir hata olursa.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
