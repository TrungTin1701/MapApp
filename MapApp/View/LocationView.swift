//
//  LocationView.swift
//  MapApp
//
//  Created by TrungTin on 12/2/22.
//

import SwiftUI
import MapKit
struct LocationView: View {
    @EnvironmentObject private  var vm : LocationViewModel
   
    var body: some View {
       ZStack
        {
            mapLayer
                .ignoresSafeArea()
            VStack(spacing :0){
                header
                    .padding()
                Spacer()
                    locationPreviewStack
            }
            .sheet(item: $vm.sheetDescription, onDismiss: nil) { Location in
                LocationDetailView(location: Location)
            }
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
        
}
extension LocationView {
    private var header : some View {
        VStack{
            Button(action: vm.toggleLocationList) {
                Text(vm.firstLocation.name + " ," + vm.firstLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height : 55)
                    .frame (maxWidth: .infinity)
                    .animation(.none, value: vm.firstLocation)
                    .overlay(alignment: .leading, content: {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
                       
                    )

            }
            
                if(vm.showLocationList){
                LcationListViews()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.7), radius: 30, x: 0, y: 15)
    }
    private var mapLayer : some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates ) {
                LocationMapAnnotaition()
                    .scaleEffect(vm.firstLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        )
    }
    private var locationPreviewStack :some View{
        ZStack{
            ForEach(vm.locations) {
                location in
                
                if vm.firstLocation==location{
                    LocationPreviewView (location: location)
                        .shadow(color: Color.red.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
                }
            }
        }
    }
}
