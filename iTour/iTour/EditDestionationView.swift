//
//  EditDestionationView.swift
//  iTour
//
//  Created by Yavuz Kaan Akyüz on 6.07.2024.
//

import SwiftUI
import SwiftData

struct EditDestionationView: View {
    @Bindable var destionation: Destination
    @State private var newSightName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destionation.name)
            TextField("Details", text: $destionation.details, axis: .vertical)
            DatePicker("Date", selection: $destionation.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destionation.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destionation.sights) { sight in
                    Text(sight.name)
                }
                
                HStack {
                    TextField("Add a new sight in \(destionation.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
            
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destionation.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestionationView(destionation: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
    
}
