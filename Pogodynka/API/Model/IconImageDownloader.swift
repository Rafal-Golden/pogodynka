//
//  IconImageDownloader.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import UIKit

protocol DownloadDataTaskProtocol {
    func run(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class DownloadDataTask: DownloadDataTaskProtocol {
    func run(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        })
        task.resume()
    }
}

class IconImageDownloader {
    let downloadDataTask: DownloadDataTaskProtocol
    private let hostURL: URL?
    private(set) var imageURL: URL?
    
    init(hostURL: URL?, downloadDataTask: DownloadDataTaskProtocol) {
        self.downloadDataTask = downloadDataTask
        self.hostURL = hostURL
        self.imageURL = nil
    }
    
    func download(iconName: String, completed: @escaping (UIImage?) -> Void) {
        self.imageURL = hostURL?.appendingPathComponent(iconName+"@2x.png")
        
        guard let url = imageURL else {
            completed(nil)
            return
        }
        
        let request = URLRequest(url: url)
        downloadDataTask.run(with: request) { imgData, _, error in
            if let imgData, error == nil {
                completed(UIImage(data: imgData))
            } else {
                completed(nil)
            }
        }
    }
}

extension IconImageDownloader {
    convenience init(downloadDataTask: DownloadDataTaskProtocol = DownloadDataTask()) {
        let baseURL = URL(string: "https://openweathermap.org/img/wn/")
        self.init(hostURL: baseURL, downloadDataTask: downloadDataTask)
    }
}

