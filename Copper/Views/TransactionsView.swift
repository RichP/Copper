//
//  ContentView.swift
//  Copper
//
//  Created by user.admin on 30/11/2021.
//

import SwiftUI
import CoreData

struct TransactionsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: OrderRepository.request)
    private var items: FetchedResults<OrderItem>
    
    var body: some View {
        if items.isEmpty {
            DownloadView()
        } else {
            List {
                ForEach(items) { item in
                    let vm = OrderViewModel(orderData: item)
                    TransactionRow(transaction: vm)
                }
                
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            TransactionsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

struct TransactionRow: View {
    var transaction: OrderViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.copper(size: 15))
                Text(transaction.dateString)
                    .font(.copper(size: 13))
                    .foregroundColor(.copperGrey)
            }
            .padding(.top, 12)
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(transaction.valueString)
                    .font(.copper(size: 15))
                Text(transaction.statusString)
                    .font(.copper(size: 13))
                    .foregroundColor(.copperGrey)
            }
            .padding(.bottom, 11)
        }
        .foregroundColor(.white)
    }
}
