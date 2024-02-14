//
//  DownloadViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit

class DownloadViewController: UITabBarController , UITableViewDelegate , UITableViewDataSource {
 
    

    private var movies : [TitleItem] = []
   
  private let downloadTableView : UITableView = {
      let downloadTable = UITableView()
      downloadTable.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
      return downloadTable
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(downloadTableView)
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        downloadTableView.dataSource = self
        downloadTableView.delegate = self
        
        
        fetchLocalStorageForDownload()
        
    }
    
    override func viewDidLayoutSubviews() {
        downloadTableView.frame =  CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
       
        
    }
    
    func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingDataFromDatabase { result in
            switch result {
            case.success(let fetchedData):
                self.movies = fetchedData
                self.downloadTableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: TitleViewModel(titleName: movies[indexPath.row].original_title ?? "", posterUrl: movies[indexPath.row].poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 140
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              // Silme işlemini burada yönetin
              deleteTitle(at: indexPath)
          }
      }

      // Silme onay düğmesini göstermek için
      func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
          return "Sil"
      }

      private func deleteTitle(at indexPath: IndexPath) {
          // CoreData'den silme işlemini burada yönetin
          let titleItem = movies[indexPath.row]
          DataPersistenceManager.shared.deleteItem(titleItem: titleItem) { [weak self] result in
              switch result {
              case .success:
                  // Lokal diziden silme işlemi
                  self?.movies.remove(at: indexPath.row)
                  // TableView'dan silme işlemi
                  self?.downloadTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

              case .failure(let error):
                  print("Hata: \(error)")
              }
          }
      }
}
