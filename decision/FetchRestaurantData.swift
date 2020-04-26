 //
 //  FetchRestaurantData.swift
 //  decision
 //
 //  Created by David Paner on 4/18/20.
 //  Copyright © 2020 David Paner. All rights reserved.
 //
 
 import Foundation
 extension ResultsView {
    func retrieve(latitude: Double,
                  longitude: Double,
                  price: String,
                  radius: Int,
                  limit: Int,
                  sortBy: String,
                  completionHander: @escaping ([Restaurant]?, Error?) -> Void) {
        let apiKey = "YywY-GlOWAQKHcOECD0Sj_Ph0bM4deIV2xWn7wO1FJg-0xsFTSGN6LoY7EOKRh9vuJ1A7x9spwdG7D7cG2Sywnl0UOv86TD1eakePv0N0fbA6raqo2-94y6ltNiaXnYx";
        //creating URL Request
        let baseURL = "https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(latitude)&longitude=\(longitude)&price=\(price)&radius=\(radius)&limit=\(limit)&sort_by=\(sortBy)"
        print(price)
        print(baseURL)

        let url = URL(string: baseURL);
        print(url)
        var request = URLRequest(url: url!)
        
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //Fetch Response from YELP
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completionHander(nil, error)
            }
            do {
                
                // Read data as JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
         
                //main dictionary
                guard let resp = json as? NSDictionary else {return}
           
            
                //Businesses
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else {return}
          
                var restaurantsList: [Restaurant] = []
                // Accessing each business
                
                
                for business in businesses {
                    var restaurant = Restaurant()
                    
                    restaurant.name = business.value(forKey: "name") as? String
                    restaurant.distance = business.value(forKey: "distance") as? Double
                    
                    let address = business.value(forKeyPath: "location.display_address") as? [String]
                    restaurant.address = address?.joined(separator: "\n")
                    restaurant.price = business.value(forKey: "price") as? String
                    
                    restaurantsList.append(restaurant)
                
                    
                    
                    
                }
                
                completionHander(restaurantsList, nil)
            } catch {
                print("error")
            }
        }.resume()
        
        
    }
 }
