//
//  ViewController.swift
//  decision
//
//  Created by David Paner on 4/17/20.
//  Copyright © 2020 David Paner. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()
    var resultSearchController:UISearchController? = nil
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
        //location setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
      
   
       
        // Do any additional setup after loading the view.
    }
    @IBAction func toDecision(_ sender: Any) {
        performSegue(withIdentifier: "toDecisionSegue", sender: self.coordinates)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let dest = segue.destination as? OptionViewController, let input = sender as? CLLocationCoordinate2D {
            dest.coordinates = input
               }
    }
}


extension ViewController : CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: \(locations.first?.coordinate.latitude)")
            print("location:: \(locations.first?.coordinate.longitude)")
            self.coordinates = locations.first!.coordinate
        }

    }
}
//
//@IBAction func toResultsViewAction(_ sender: Any) {
//       let input = [price, radius, numRestaurants] as [Any]
//       performSegue(withIdentifier: "toResultsView", sender: input)
//   }
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if let dest = segue.destination as? ResultsView, let input = sender as? [Any] {
//           dest.chosenRadius = input[1] as! Int
//           dest.chosenPrice = input[0] as! String
//           dest.numRestaurants = input[2] as! Int
//       }
//   }
