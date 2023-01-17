//
//  AuthenticationViewModel.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    func login(user: String, pass: String, completion: @escaping (Int) -> ()){
        let url = URL(string: "https://superapi.netlify.app/api/login")
        
        let httpBody: [String : String] = ["user": user, "pass": pass]
        let finalBody = try? JSONSerialization.data(withJSONObject: httpBody)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil {
                    completion(httpResponse.statusCode)
                    print(httpResponse.statusCode)
                }
            }

        }
        
        task.resume()
    }
    
    func register(user: String, pass: String){
        let url = URL(string: "https://superapi.netlify.app/api/register")
        
        let httpBody: [String : String] = ["user": user, "pass": pass]
        let finalBody = try? JSONSerialization.data(withJSONObject: httpBody)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil {
                    print(httpResponse.statusCode)
                }
            }

        }
        
        task.resume()
    }
}


