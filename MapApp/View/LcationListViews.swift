//
//  LcationListViews.swift
//  MapApp
//
//  Created by TrungTin on 12/2/22.
//

import SwiftUI

struct LcationListViews: View {
    @EnvironmentObject private var vm  : LocationViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations){
                location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    ListLocationView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LcationListViews_Previews: PreviewProvider {
    static var previews: some View {
        LcationListViews()
            .environmentObject(LocationViewModel())
    }
}
extension LcationListViews {
    private func ListLocationView(location :Location)->some View {
        HStack{
            if let imageNames = location.imageNames.first{
                Image(imageNames)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .frame(width: 45 , height: 45)
            }
            VStack(alignment :.leading)
                {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                        
            }
                .frame(maxWidth : .infinity, alignment :.leading )
               
        }

    }
}
