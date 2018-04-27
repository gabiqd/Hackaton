//
//  Crane.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 27/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import GeoFire
import CoreLocation
import MapKit

class Crane {
    var name: String?
    var pictureUrl: String?
    var dni: String?
    var position: [String]?
    var phone: String?
    var distance: String?
    
    init(name: String?, pictureUrl: String?, dni: String?, position: String?, phone: String?) {
        
        self.name = name
        self.pictureUrl = pictureUrl
        self.dni = dni
        self.position = position?.split{$0 == "_"}.map(String.init)
        self.phone = phone
        
    }
    
    
    func getDistanceForProfessional(currentLocation: CLLocation) -> String {
        
        let latitude = Double.init(position![0])
        let longitude = Double.init(position![1])
        let distanceMeters = CLLocation(latitude: latitude!,longitude: longitude!).distance(from: currentLocation)
        
        let distanceKilometers = distanceMeters / 1000.00
        
        let roundedDistanceKilometers = String(Double(round(100 * distanceKilometers) / 100)) + " km"
        
        distance = roundedDistanceKilometers
        
        return roundedDistanceKilometers
    }
    
    func getDistanceForProfessionalDouble(currentLocation: CLLocation) -> Double {
        
        let latitude = Double.init(position![0])!
        let longitude = Double.init(position![1])!
        
        let latitudeDegrees : CLLocationDegrees = latitude
        let longitudeDegrees : CLLocationDegrees = longitude
        
        let location : CLLocation = CLLocation.init(latitude: latitudeDegrees, longitude: longitudeDegrees)
        
        let distanceMeters = currentLocation.distance(from: location)
        let distanceKilometers = distanceMeters / 1000.00
        
        let roundedDistanceKilometers = Double(round(100 * distanceKilometers) / 100)
        
        return roundedDistanceKilometers
    }
    
    func getLocationCoordinate() -> CLLocationCoordinate2D {
        let latitude = Double.init(position![0])!
        let longitude = Double.init(position![1])!
        
        let latitudeDegrees : CLLocationDegrees = latitude
        let longitudeDegrees : CLLocationDegrees = longitude
        
        let location : CLLocation = CLLocation.init(latitude: latitudeDegrees, longitude: longitudeDegrees)
        
        return location.coordinate
    }
}
