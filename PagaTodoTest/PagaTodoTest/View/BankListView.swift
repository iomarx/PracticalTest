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
        List(viewModel.banks) { bank in
            HStack {
                Image(systemName: "creditcard")
                VStack(alignment: .leading) {
                    Text(bank.bankName).font(.title)
                    Text(bank.description).font(.body)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankListView()
    }
}
