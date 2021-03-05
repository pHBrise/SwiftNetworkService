//
//  File.swift
//  
//
//  Created by Mac mini ssd500 on 4/3/21.
//

import Foundation

protocol NetworkLoader {
    func loadData(using request:URLRequest,with completion:@escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Networking error with \(String(describing: request.url?.absoluteString)): \n\(error)")
            }

            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("Bad status code: \(statusCode)")
                }
            }

            completion(data, response as? HTTPURLResponse, error)
        }.resume()
    }

}
