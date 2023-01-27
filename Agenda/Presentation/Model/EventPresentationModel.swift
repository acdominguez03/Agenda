//
//  EventPresentationModel.swift
//  Agenda
//
//  Created by Apps2T on 27/1/23.
//

import Foundation

struct EventPresentationModel: Identifiable {
    // el id se genera cada vez que se instancia/crea el modelo, es necesario para el ForEach del LazyVStack ya que SwiftUI así lo requiere
    let id = UUID()
    let name: String
    let date: Int
}
