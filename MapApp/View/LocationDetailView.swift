//
//  LocationDetailView.swift
//  MapApp
//
//  Created by TrungTin on 12/3/22.
//

import SwiftUI
import MapKit
struct LocationDetailView: View {
    
    let location : Location
    @EnvironmentObject private var vm : LocationViewModel
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth : .infinity,alignment: .leading)
                .padding()
            }
          
        }
        
        .background(.ultraThickMaterial)
        .ignoresSafeArea()
        .overlay(backButton,alignment: .topLeading)
        
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location:  LocationsDataService.locations.first!)
            .environmentObject(LocationViewModel())
    }
       
}
extension LocationDetailView  {
     private var imageSection :some View {
        TabView{
            ForEach(location.imageNames, id: \.self) {
                
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    
            }
        }
        .frame( height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection : some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.subheadline )
                .foregroundColor(.secondary)
        }
    }
    private var descriptionSection :some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link ){
                Link("Read More on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    private var mapLayer :some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: vm.mapspan)), annotationItems: [location]) {location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotaition()
                    .shadow(radius: 10)
                    
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    private var backButton :some View {
        Button {
            vm.sheetDescription=nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
}
