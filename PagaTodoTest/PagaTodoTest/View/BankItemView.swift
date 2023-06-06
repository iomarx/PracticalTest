//
//  BankItemView.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BankItemView: View {
    let bank: Bank
    
    var body: some View {
        HStack {
            let url = URL(string: bank.url)
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70)
            } else {
                WebImage(url: url)
                    .scaledToFit()
                    .frame(width: 70)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(bank.bankName).font(.title)
                Text(bank.description).font(.caption)
            }
        }
    }
}

struct BankItemView_Previews: PreviewProvider {
    static var previews: some View {
        BankItemView(bank: Bank(bankName: "Paga Todo",
                                description: "Banco Paga Todo es Para Todos",
                                age: 10,
                                url: "https://firebasestorage.googleapis.com/v0/b/stagingpagatodo-286214.appspot.com/o/Challenge%2Flogo-pagatodo.jpeg?alt=media&token=38b6ac4d-85ac-4288-bada-88eb5a0dec20"))
    }
}
