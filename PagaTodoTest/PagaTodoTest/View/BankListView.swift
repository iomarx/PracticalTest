//
//  BankListView.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import SwiftUI

struct BankListView: View {
    @ObservedObject private var viewModel = BankListViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankListView()
    }
}
