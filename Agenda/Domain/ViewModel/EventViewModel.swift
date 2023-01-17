//
//  EventViewModel.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class EventViewModel: ObservableObject {
    
    @Published var events = [Event?]()
    
    func getEvents() {
        NetworkHelper.shared.requestProvider(url: "https://superapi.netlify.app/api/db/eventos", type: .GET) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data, let response = response as? HTTPURLResponse{
                print(response.statusCode)
                print(String(bytes: data, encoding: .utf8))
                
                do {
                    let events = try JSONDecoder().decode([Event?].self, from: data)
                    self.events = events
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func setNewEvent(name: String, date: Int) {
        let url = URL(string: "https://superapi.netlify.app/api/db/eventos")
        let httpBody: [String : Any] = ["name": name, "date": date]
        let finalBody = try? JSONSerialization.data(withJSONObject: httpBody)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
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


