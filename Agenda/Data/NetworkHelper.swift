//
//  NetworkHelper.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class NetworkHelper {
    
    enum RequestType: String{
        case POST
        case GET
    }
    
    //singleton
    static let shared = NetworkHelper()
    
    func requestApi(request: URLRequest , completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func requestProvider(url: String, type: RequestType = .POST, params: [String: Any]? = nil, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let url = URL(string: url)
        
        guard let url = url else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = type.rawValue
        
        if let dictionary = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        requestApi(request: request,completion: completion)
        
    }
}
