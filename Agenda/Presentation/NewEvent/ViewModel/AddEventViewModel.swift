//
//  AddEventViewModel.swift
//  Agenda
//
//  Created by Apps2T on 27/1/23.
//

import Foundation

class NewEventViewModel: ObservableObject {
    
    
    @Published var onSentNewEvent = false

    func setNewEvent(name: String, date: Double) {
        let url = "https://superapi.netlify.app/api/db/eventos"
        let params: [String : Any] = ["name": name, "date": date]
        
        NetworkHelper.shared.requestProvider(url: url, params: params) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse{
                print(response.statusCode)
                self.onSuccess()
            }
        }
    }
    
    func onSuccess() {
        onSentNewEvent = true
    }
    
}
