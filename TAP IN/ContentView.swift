//
//  ContentView.swift
//  TAP IN
//
//  Created by Preshous Austin on 2/8/23.
//Name: Preshous Austin Taylor Jones Nicole Warts Destiny Kameshia
// Home view: An app where neighbors become families


// Real events
    //

import MapKit
import SwiftUI
import CoreLocation

//This struct will be used to populate specific markers on the map
struct MarkerLocations: Identifiable {
    let id = UUID()
    let name: String
    let markerType: String
    let coordinate: CLLocationCoordinate2D
}



struct ContentView: View {
    
    @State private var address: String = ""
    
    //This line of code is used to centralize the maps location
    @State private var mapRegion = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: 42.33, longitude: -83.04),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 1.4)
    )
    
    @State var coordinatesToAdd = CLLocationCoordinate2D()
    
    @State var markers = [
        MarkerLocations(name: "Saftey Hazard", markerType: "Hazard", coordinate: CLLocationCoordinate2D(latitude: 42.42, longitude: -83)),
        MarkerLocations(name: "Jobs", markerType: "Hazard", coordinate: CLLocationCoordinate2D(latitude: 42.1, longitude: -83))
    ]
    
    
    
    var body: some View {
        
        //This line of code is used to populate a map on your UI
        VStack {
            HStack{
                TextField("address", text: $address)
                Button{
                    getLocation(from: address) { location in
                        print("Location is", location.debugDescription)
                        coordinatesToAdd = location.unsafelyUnwrapped
                    }
                    markers.append(MarkerLocations(name: address, markerType: "Hazard", coordinate: coordinatesToAdd))
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()
            Map(coordinateRegion: $mapRegion, annotationItems: markers) { location in
                MapMarker(coordinate: location.coordinate)
            }
        }
        
    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
