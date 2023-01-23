//
//  EventViewModel.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class EventViewModel: ObservableObject {
    
    @Published var events = [EventPresentationModel]()
    @Published var onSentNewEvent = false
    
    func getEvents() {
        NetworkHelper.shared.requestProvider(url: "https://superapi.netlify.app/api/db/eventos", type: .GET) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data, let response = response as? HTTPURLResponse{
                self.onSuccess(data: data)
            }
        }
    }
    
    func onSuccess(data: Data) {
        do {
            let eventsNotFiltered = try JSONDecoder().decode([EventResponseModel?].self, from: data)
                
            self.events = eventsNotFiltered.compactMap({ eventNotFiltered in
                guard let date = eventNotFiltered?.date else { return nil }
                return EventPresentationModel(name: eventNotFiltered?.name ?? "Empty Name", date: date)
            })
        } catch {
            print(error.localizedDescription)
        }
            
    }
    
    func setNewEvent(name: String, date: Double) {
        let url = "https://superapi.netlify.app/api/db/eventos"
        let params: [String : Any] = ["name": name, "date": date]
        
        NetworkHelper.shared.requestProvider(url: url, params: params) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse{
                print(response.statusCode)
                self.onSuccessNewEvent()
            }
        }
        
    }
    
    func onSuccessNewEvent() {
        onSentNewEvent = true
    }
    
}


