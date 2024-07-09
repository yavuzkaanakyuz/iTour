//
//  ContentView.swift
//  iTour
//
//  Created by Yavuz Kaan Akyüz on 6.07.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    @State private var searchText = ""
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iTour ")
                .navigationDestination(for: Destination.self, destination: EditDestionationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    Button("Add Destionation", systemImage: "plus", action: addDestionation)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florance = Destination(name: "Florance")
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florance)
        modelContext.insert(naples)
    }
    
    func addDestionation() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
        
    
}

#Preview {
    ContentView()
}
