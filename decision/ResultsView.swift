//
//  ResultsView.swift
//  decision
//
//  Created by David Paner on 4/19/20.
//  Copyright © 2020 David Paner. All rights reserved.
//

import UIKit
import SpinWheelControl
import MapKit




class ResultsView: UIViewController, SpinWheelControlDataSource, SpinWheelControlDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        print(self.numRestaurants)

        return UInt(self.numRestaurants)
    }
    
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let wedge = SpinWheelWedge()
        wedge.shape.fillColor = UIColor.black.cgColor
        wedge.label.font = UIFont(name: "Montserrat-Light", size: 20)
        if Int(index) < restaurants.count {
        wedge.label.text = restaurants[Int(index)].name
        }
        else {
            wedge.label.text = restaurants[Int(index) % restaurants.count].name
        }
        
        return wedge    }
    var spinWheelControl:SpinWheelControl!
    
    var restaurantNames:String!
    var restaurants: [Restaurant] = []
    var coordinates = CLLocationCoordinate2D()
    
    let CPLatitude: Double = 37.7159
    let CPLongitude: Double = 121.9101
    var chosenPrice = ""
    var chosenRadius = 0
    var numRestaurants = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 10
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width + 350)
        
    
        retrieve(latitude: coordinates.latitude, longitude: coordinates.longitude * -1, price: chosenPrice, radius: chosenRadius,  limit: numRestaurants, sortBy: "distance") {
            (response, error) in
            if let response = response {
            
                self.restaurants = response
                DispatchQueue.main.async{
                    
                    self.spinWheelControl = SpinWheelControl(frame: frame)
                    self.spinWheelControl.addTarget(self, action: #selector(self.spinWheelDidChangeValue), for: UIControl.Event.valueChanged)
                    self.spinWheelControl.dataSource = self
                    
                    self.spinWheelControl.reloadData()
                    self.spinWheelControl.delegate = self
                    self.view.addSubview(self.spinWheelControl)
                    
                        
                        
                    }
                    
                }
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
    @objc func spinWheelDidChangeValue(sender: AnyObject) {
        print("Value changed to " + String(self.spinWheelControl.selectedIndex))
        self.resultLabel.text = self.restaurants[self.spinWheelControl.selectedIndex].name
        self.addressLabel.text = self.restaurants[self.spinWheelControl.selectedIndex].address

    }
    
    @IBAction func backToActionView(_ sender: Any) {
        //performSegue(withIdentifier: "backSegue", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
}


//custom colors for wheel
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
