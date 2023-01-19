//
//  Event.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class EventResponseModel: Decodable{
    
    let name: String?
    let date: Double?
    
    init(name: String, date: Double){
        self.name = name
        self.date = date
    }
}

class Event{
    
    let name: String
    let date: Double
    
    init(name: String, date: Double){
        self.name = name
        self.date = date
    }
}

