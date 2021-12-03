//
//  DownloadView.swift
//  Copper
//
//  Created by Richard Pickup on 30/11/2021.
//

import SwiftUI

struct DownloadView: View {
    @ObservedObject var viewModel = OrderRepository(client: CopperTestClient())
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88)
                
                Spacer()
                    .frame(height: 28)
                
                Text("Transactions")
                    .font(.copperBold(size: 24))
                
                Spacer()
                    .frame(height: 12)
                
                Text("Click “Download” to view transaction history")
                    .foregroundColor(.copperGrey)
                    .font(.copper(size: 15))
                
                Spacer()
                    .frame(height: 40)
                
                switch viewModel.state {
                case .loading:
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .copperTint))
                        .frame(height: 56)
                default:
                    HStack {
                        Button {
                            viewModel.fetchOrders()
                        } label: {
                            Text("Download").bold()
                                .font(.copperBold(size: 16))
                        }
                    }
                    .frame(width: 213, height: 56)
                    .foregroundColor(.black)
                    .background(Color.copperTint)
                    .cornerRadius(4.0)
                }
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
