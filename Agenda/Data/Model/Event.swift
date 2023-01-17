//
//  Event.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation

class Event: Identifiable,Decodable{
    
    let name: String?
    let date: Int?
    
    init(name: String, date: Int){
        self.name = name
        self.date = date
    }
}

