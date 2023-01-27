//
//  LoginViewModel.swift
//  Agenda
//
//  Created by Apps2T on 27/1/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    func login(user: String, pass: String, completion: @escaping (Int) -> ()){
        let url = "https://superapi.netlify.app/api/login"
        
        let params: [String : String] = ["user": user, "pass": pass]
        
        NetworkHelper.shared.requestProvider(url: url, params: params) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil {
                    completion(httpResponse.statusCode)
                    print(httpResponse.statusCode)
                }
            }
        }
    }
}
