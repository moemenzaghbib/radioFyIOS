//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "MyDataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error {
//                fatalError("Failed to load persistent stores: \(error)")
//            }
//        })
//        return container
//    }()
//    
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//    
//    func insertSong(name: String, url: URL) -> Song? {
//        let context = persistentContainer.viewContext
//        let song = Song()
//        song.name = name
//        song.url = url
//        
//        do {
//            try context.save()
//            return song
//        } catch {
//            print("Failed to insert song: \(error)")
//            return nil
//        }
//    }
//    
//    func fetchSongs() -> [Song] {
//        let context = persistentContainer.viewContext
//        let request: NSFetchRequest<Song> = NSFetchRequest(entityName: "Song")
//
//        do {
//            let songs = try context.fetch(request)
//            return songs
//        } catch {
//            print("Failed to fetch songs: \(error)")
//            return []
//        }
//    }
//    
//    func deleteSong(_ song: Song) {
//        let context = persistentContainer.viewContext
//        context.delete(song)
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to delete song: \(error)")
//        }
//    }
//}
