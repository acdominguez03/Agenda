//
//  NewEventView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct NewEventView: View {
    
    @State var selectedDate: Date = Date()
    @State var nameEvent: String = ""
    @Binding var events: [Event?]
    @StateObject var eventViewModel: EventViewModel = EventViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            CustomTextField(imageName: "pencil", placeholderText: "Name of the event",text: $nameEvent)
                    .padding()
            
            DatePicker("Select Date", selection: $selectedDate)
                .datePickerStyle(.graphical)
                .padding(.horizontal)
            
            Button {
                let someDate = selectedDate
                let timeInterval = someDate.timeIntervalSince1970
                let finalDate = Double(Int(timeInterval) * 1000)
                
                eventViewModel.setNewEvent(name: nameEvent, date: finalDate)
                events.append(Event(name: nameEvent, date: finalDate))
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Event")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }.padding()
            
            Spacer()
        }
        .background(Color("Background"))
    }
}

//struct NewEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewEventView(events: Event(name: "Hola", date: 126476230000))
//   }
//}

