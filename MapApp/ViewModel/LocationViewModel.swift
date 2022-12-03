//
//  LocationViewModel.swift
//  MapApp
//
//  Created by TrungTin on 12/2/22.
//

import Foundation
import MapKit
import SwiftUI
class LocationViewModel : ObservableObject {
    
    @Published  var locations : [Location]
    
    @Published var firstLocation : Location{
        didSet{
            updateMapRegion(location:  firstLocation)
        }
    }
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    // A Variable to control when show LocationList
    @Published var showLocationList : Bool = false
    //  sheet Location Description
    @Published var sheetDescription : Location? = nil
    let mapspan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    init ()
    {
        let locations = LocationsDataService.locations
        self.locations =  locations
        self.firstLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
       
    }
    private func updateMapRegion(location :Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapspan
            )
            
        }
    }
     func toggleLocationList (){
        withAnimation(.easeInOut)
        {
            showLocationList.toggle()
        }
    }
    func showNextLocation (location : Location){
        withAnimation(
            .easeInOut
        ){
            firstLocation=location
            showLocationList=false
        }
    }
    func buttonNextLocation (){
        guard let currentIndex = locations.firstIndex(where: {$0==firstLocation}) else {return }
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next Index is Valid
            // Reset Next Index to 0
            guard let firstLoca = locations.first else {return  }
            showNextLocation(location: firstLoca)
            return
        }
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
