//
//  OptionViewController.swift
//  decision
//
//  Created by David Paner on 4/17/20.
//  Copyright © 2020 David Paner. All rights reserved.
//

import UIKit
import SpinWheelControl
import MapKit



class OptionViewController: UIViewController {
    var restaurants: [Restaurant] = []
    var coordinates = CLLocationCoordinate2D()
    let CPLatitude: Double = 40.782483
    let CPLongitude: Double = -73.963540
    var price = "1"
    var numRestaurants = 2
    var limit = 2
    //meters default is half a mile
    var radius = 805
    let sortBy = "distance"
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var priceSliderValue: UILabel!
    @IBOutlet weak var radiusValue: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var numberRestaurantsValue: UILabel!
    @IBOutlet weak var numberRestaurantsSlider: UISlider!
    
    @IBOutlet weak var enterButton: UIButton!
    
    //    func retrieve(latitude: Double,
    //    longitude: Double,
    //        price: Int,
    //        limit: Int,
    //        sortBy: String,
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 10
        priceSlider.maximumValue = 4;
        priceSlider.minimumValue = 1;
        radiusSlider.maximumValue = 3.33;
        radiusSlider.minimumValue = 0.333;
        numberRestaurantsSlider.maximumValue = 10
        numberRestaurantsSlider.minimumValue = 2
        
        
        
        
        
        
    }
    
    @IBAction func radiusSliderValueChanged(_ sender: Any) {
        let val = round(radiusSlider.value * 3) * 0.5
        radiusValue.text = "\(val) mi"
        self.radius = Int(round(val * 1609.34))
    }
    
    @IBAction func priceSliderValueChanged(_ sender: Any) {
        let price = Int(roundf(priceSlider.value))
        var apiPrice = "1"
        switch price {
        case 1:
            priceSliderValue.text = "$"
            apiPrice = "1"
        case 2:
            priceSliderValue.text = "$$"
            apiPrice = "1,2"
        case 3:
            priceSliderValue.text = "$$$"
            apiPrice = "1,2,3"
        case 4:
            priceSliderValue.text = "$$$$"
            apiPrice = "1,2,3,4"
            
        default:
            priceSliderValue.text = "$"
        }
        
        self.price = apiPrice
        
    }
    @IBAction func numberRestaurantsValueChanged(_ sender: Any) {
        numRestaurants = Int(numberRestaurantsSlider.value)
        numberRestaurantsValue.text = "\(numRestaurants)"
    }
    
    
    @IBAction func toResultsViewAction(_ sender: Any) {
        let input = [price, radius, numRestaurants, coordinates] as [Any]
        performSegue(withIdentifier: "toResultsView", sender: input)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ResultsView, let input = sender as? [Any] {
            dest.chosenRadius = input[1] as! Int
            dest.chosenPrice = input[0] as! String
            dest.numRestaurants = input[2] as! Int
            dest.coordinates = input[3] as! CLLocationCoordinate2D
        }
    }
    
    // Do any additional setup after loading the view.
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
