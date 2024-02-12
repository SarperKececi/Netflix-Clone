import Foundation

class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let apiKey  = "2d6ab1fde75871f50873ce687bc4b0bf"
        static let baseURL = "https://api.themoviedb.org/3"
        static let language = "en-US"
        static let page = 1
        static let Youtube_APIKEY = "AIzaSyB6SQLPX5rtQFCJ4HVTTl-FTeMsBeFZZ7M"
        static let Youtube_BASEURL = "https://youtube.googleapis.com/youtube/v3/search?key="
    }
    
    enum APIError {
        case failedToGetData
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        // API'den veri çekmek için URL oluşturma
        guard let url = URL(string: Constants.baseURL + "/movie/upcoming" + "?api_key=" + Constants.apiKey + "&language=" + Constants.language + "&page=" + String(Constants.page)) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping(Result<[Title],Error>) -> Void) {
        
        // API'den veri çekmek için URL oluşturma
        guard let url = URL(string: Constants.baseURL + "/movie/top_rated" + "?api_key=" + Constants.apiKey + "&language=" + Constants.language + "&page=" + String(Constants.page)) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void) {
        // API URL'sini oluştur
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=2d6ab1fde75871f50873ce687bc4b0bf&language=en-US&page=1") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                    
                } catch {
                    completion(.failure(APIError.failedToGetData as! Error))
                }
            }
        }
        
        task.resume()
    }
    func getPopularMovies(completion: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/movie/popular" + "?api_key=" + Constants.apiKey + "&language=" + Constants.language + "&page=" + String(Constants.page)) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(APIError.failedToGetData as! Error))
                }
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title],Error>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/movie/upcoming" + "?api_key=" + Constants.apiKey + "&language=" + Constants.language + "&page=" + String(Constants.page)) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(APIError.failedToGetData as! Error))
                }
            }
        }
        task.resume()
    }
    
    func discoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/discover/movie" +
                            "?api_key=" + Constants.apiKey +
                            "&language=" + Constants.language +
                            "&page=" + String(Constants.page)) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(APIError.failedToGetData as! Error))
                }
            }
        }
        task.resume()
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        // API'den veri çekmek için URL oluşturma
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid query", code: 0, userInfo: nil)))
            return
        }
        
        guard let url = URL(string: Constants.baseURL + "/search/movie" + "?api_key=" + Constants.apiKey + "&language=" + Constants.language + "&query=" + encodedQuery) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TitleMovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func getMovieYoutube(with query: String, completionHandler: @escaping (Result<YouTubeSearchResult, Error>) -> Void) {
          // Youtube API için URL oluşturma
          guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
              completionHandler(.failure(NSError(domain: "Invalid query", code: 0, userInfo: nil)))
              return
          }

          let youtubeURL = Constants.Youtube_BASEURL + Constants.Youtube_APIKEY + "&q=" + encodedQuery

          guard let url = URL(string: youtubeURL) else {
              completionHandler(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
              return
          }

          var request = URLRequest(url: url)
          request.httpMethod = "GET"

          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              if let error = error {
                  completionHandler(.failure(error))
                  return
              }

              if let data = data {
                          do {
                              let decoder = JSONDecoder()
                              let result = try decoder.decode(YouTubeSearchResponse.self, from: data)

                              if let firstItem = result.items.first {
                                  completionHandler(.success(firstItem))
                              } else {
                                  let noResultError = NSError(domain: "No items found", code: 0, userInfo: nil)
                                  completionHandler(.failure(noResultError))
                              }
                          } catch {
                              completionHandler(.failure(error))
                          }
                      }
                  }

                  task.resume()
              }

}
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*      // Youtube API için URL oluşturma
          guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
              completionHandler(.failure(NSError(domain: "Invalid query", code: 0, userInfo: nil)))
              return
          }

          let youtubeURL = Constants.Youtube_BASEURL + Constants.Youtube_APIKEY + "&q=" + encodedQuery

          guard let url = URL(string: youtubeURL) else {
              completionHandler(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
              return
          }

          var request = URLRequest(url: url)
          request.httpMethod = "GET"

          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              if let error = error {
                  completionHandler(.failure(error))
                  return
              }

              if let data = data {
                  do {
                  
                      let decoder = JSONDecoder()
                      let result = try decoder.decode(TitleYoutubeResponse.self, from: data)
                      completionHandler(.success(result.items))
                  } catch {
                      completionHandler(.failure(error))
                  }
              }
          }

          task.resume()
      }
*/
