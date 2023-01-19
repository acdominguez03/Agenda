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
                do {
                    let eventsNotFiltered = try JSONDecoder().decode([EventResponseModel?].self, from: data)
                    
                    self.events = eventsNotFiltered.compactMap({
                        guard let date = $0?.date else {return nil}
                            return Event(name: $0?.name ?? "Nombre no encontrado", date: date)
                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func setNewEvent(name: String, date: Double) {
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


