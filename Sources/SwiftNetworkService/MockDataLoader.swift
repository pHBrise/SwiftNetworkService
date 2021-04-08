//
//  File.swift
//  
//
//  Created by Mac mini ssd500 on 7/4/21.
//

import Foundation


class MockDataLoader: NetworkLoader {

    
    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(data: Data?, response:URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    private(set) var request: URLRequest?
    
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            self.request = request
            completion(self.data, self.response, self.error)
        }
    }
}
