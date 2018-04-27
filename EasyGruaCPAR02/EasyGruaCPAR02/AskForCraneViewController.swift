//
//  AskForCraneViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Firebase
import Kingfisher

class AskForCraneViewController: UIViewController {
    var mapView: MKMapView!
    var locationManager:CLLocationManager!
    var askButton: StyledButton!
    var craneList = [Crane]()
    var craneInfoCard: CraneInfoCard!
    var userLocation: CLLocation!

    override func viewWillAppear(_ animated: Bool) {
        setNavigationLogo(viewcontroller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        
        initViews()
        setUpConstraints()
        determineMyCurrentLocation()
    }
    
    func initViews() {
        mapView = {
            let mapView = MKMapView()
            mapView.translatesAutoresizingMaskIntoConstraints = false
            mapView.mapType = MKMapType.standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            mapView.delegate = self
            return mapView
        }()
        
        askButton = {
            let askButton = StyledButton()
            askButton.translatesAutoresizingMaskIntoConstraints = false
            askButton.setTitle("Buscar grúa", for: .normal)
            askButton.addTarget(self, action: #selector(getCraneAvailable), for: .touchUpInside)
            return askButton
        }()
        
        craneInfoCard = {
            let craneInfoCard = CraneInfoCard()
            craneInfoCard.translatesAutoresizingMaskIntoConstraints = false
            craneInfoCard.isHidden = true
            return craneInfoCard
        }()
    }
    
    func setUpConstraints() {
        self.view.addSubview(mapView)
        self.view.addSubview(askButton)
        self.view.addSubview(craneInfoCard)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mapView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mapView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": askButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": askButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": craneInfoCard]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": craneInfoCard]))
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    @objc func getCraneAvailable() {
        let rootReference = Database.database().reference()
        
        rootReference.child("gruas").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let childValue = snap.value as? NSDictionary
                
                let name = childValue?["name"] as! String?
                let pictureUrl = childValue?["pictureUrl"] as! String?
                let dni = childValue?["dni"] as! String?
                let position = childValue?["position"] as! String?
                let phone = childValue?["phone"] as! String?
                
                let crane = Crane(name: name, pictureUrl: pictureUrl, dni: dni, position: position, phone: phone)
                
                let cranePin = CustomPointAnnotation()
                cranePin.coordinate = crane.getLocationCoordinate()
                cranePin.title = crane.dni
                cranePin.isCrane = true
                cranePin.tag = "tag_1"
                
                self.mapView.addAnnotation(cranePin)
                self.craneList.append(crane)
            }
            
            
            self.askButton.isHidden = true
            }) { (error) in
                print(error.localizedDescription as Any)
            }
    }
}

extension AskForCraneViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        manager.stopUpdatingLocation()
        
        //mapView.removeAnnotation(userPin)
        
        let location = locations.last! as CLLocation
        userLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        mapView.setRegion(region, animated: true)
        
        let userPin = CustomPointAnnotation()
        userPin.coordinate = location.coordinate
        userPin.title = "yo"
        userPin.isCrane = false
        userPin.tag = "tag_2"
        
        mapView.addAnnotation(userPin)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}

extension AskForCraneViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        for crane in craneList {
            if view.annotation?.title == crane.dni{
                craneInfoCard.isHidden = false
                craneInfoCard.parentViewController = self
                craneInfoCard.nameLabel.text = crane.name
                craneInfoCard.dniLabel.text = "DNI: \(crane.dni ?? "")"
                
                
                let request = MKDirectionsRequest()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: crane.getLocationCoordinate(), addressDictionary: nil))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate, addressDictionary: nil))
                request.transportType = .automobile
                let directions = MKDirections(request: request)
                directions.calculateETA { response, error -> Void in
                    if let err = error {
                        print(err.localizedDescription)
                        //print(err.userInfo["NSLocalizedFailureReason"])
                        return
                    }
                    let aproxtime = response!.expectedTravelTime/60
                    let roundedTime = round(100*aproxtime)/100
                    self.craneInfoCard.aproxTime.text = "Llegará en \(roundedTime) minutos."
                    print(response!.expectedTravelTime/60)
                }
                
                craneInfoCard.distanceLabel.text = "Se encuentra a \(crane.getDistanceForProfessional(currentLocation: userLocation))"
                
                guard let profilePicURL = crane.pictureUrl else{
                    craneInfoCard.profileImageView.image = UIImage(named: "userPictureDefault")
                    return
                }
                
                let profileURL = URL(string: profilePicURL)!
                let placeholderImage = UIImage(named: "userPictureDefault")
                craneInfoCard.profileImageView.kf.indicatorType = .activity
                craneInfoCard.profileImageView.kf.setImage(with: profileURL, placeholder: placeholderImage)
                if let safePhone = crane.phone{
                    craneInfoCard.callPhone = safePhone
                }
                
                print(crane.getDistanceForProfessional(currentLocation: userLocation))
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        var imagesPath: [String: String] = ["tag_1": "crane", "tag_2": "car"]
        let reuseId = "craneId"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let customannotation = annotation as! CustomPointAnnotation
            anView!.image = UIImage(named: imagesPath[customannotation.tag]!)// (customannotation.tag))
            let transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            anView!.transform = transform
            anView!.canShowCallout = true
        }
        
        return anView
    }
}
