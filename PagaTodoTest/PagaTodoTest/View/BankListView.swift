//
//  BankListView.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import SwiftUI

struct BankListView: View {
    @ObservedObject private var viewModel = BankListViewModel(repository: BanksRepositoryImpl(context: PersistenceController.shared.context))
    
    var body: some View {
        NavigationView {
            List(viewModel.banks) { bank in
                BankItemView(bank: bank)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankListView()
    }
}
