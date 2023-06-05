//
//  BankListView.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import SwiftUI

struct BankListView: View {
    @ObservedObject private var viewModel = BankListViewModel(repository: BanksRepositoryImpl())
    
    var body: some View {
        NavigationView {
            List(viewModel.banks) { bank in
                HStack {
                    Image(systemName: "creditcard")
                    VStack(alignment: .leading) {
                        Text(bank.bankName).font(.title)
                        Text(bank.description).font(.body)
                    }
                }
            }.navigationTitle("Banks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankListView()
    }
}
