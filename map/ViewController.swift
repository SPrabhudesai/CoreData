//
//  ViewController.swift
//  map
//
//  Created by shailesh on 07/09/18.
//  Copyright © 2018 Shailesh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet var nameTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let url = "http://www.kaleidosblog.com/tutorial/login/api/login"
     override func viewDidLoad() {
        super.viewDidLoad()
        updateMap()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMap(){
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "My location"
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        
        //centerMap(locValue)
    }

    func zd(){
        let username = nameTextField.text
        let password = passwordTextField.text
        
        if (username == "" || password == ""){
            print("OK")
        }
        else{
        let params = ["username":username, "password":password] as! Dictionary<String, String>
        
        let backGround = WebService()
        backGround.callPostService(url: url, parameters: params as NSDictionary)
           // backGround.postAction(url: url, paramater: params as NSDictionary)
            
        }
    }
    @IBAction func loginButtonClicked(_ sender: Any) {
        zd()
    }
    
}

