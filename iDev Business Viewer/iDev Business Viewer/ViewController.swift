//
//  ViewController.swift
//  iDev Business Viewer
//
//  Created by Hemanth Devarapalli on 1/11/17.
//  Copyright © 2017 Hemanth Devarapalli. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var token:String?
    
    let appId:String = "TYslH-CAecjJxLNs96KduA"
    let appSecret:String = "HTvLOVQ3g4HRz2mTcc00GcFznBC8zvKsLRMsRJYkWZnZy89c2RJ8ClAwrIjYF0Sh"
    
    let baseUrl = "https://api.yelp.com/oauth2/token"
    
    let searchUrl = "https://api.yelp.com/v3/businesses/search"
    
    let location = "West Lafayette, IN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getToken() {
        Alamofire.request(baseUrl, method: .post, parameters: ["grant_type": "client_credentials", "client_id": appId, "client_secret": appSecret], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("error")
                    return
                }
                
                //print(info)
                let json = JSON(info)
                self.token = json["access_token"].stringValue
                self.loadBusiness()
            }
        }
    }
    
    func loadBusiness() {
        Alamofire.request(searchUrl, method: .get, parameters: ["location": location], encoding: URLEncoding.default, headers: ["authorization": "Bearer \(token!)"]).responseJSON { (response) in
            if response.result.isSuccess{
                guard let data = response.result.value else {
                    print("error")
                    return
                }
                
                let respData = JSON(data)
                print(respData)
                let businesses = respData["businesses"]
                self.nameLabel.text = businesses[0]["name"].stringValue
                self.phoneLabel.text = businesses[0]["phone"].stringValue
                self.priceLabel.text = businesses[0]["price"].stringValue
                self.addressLabel.text = businesses[0]["location"]["address1"].stringValue + ", " +  businesses[0]["location"]["city"].stringValue + ", " + businesses[0]["location"]["state"].stringValue
                
                let imageURL = URL(string: businesses[0]["image_url"].stringValue)
                let imageRequest = URLRequest(url: imageURL!)
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: imageRequest, completionHandler: {
                    (data, response, error) in
                    guard let image = data else {
                        print(error?.localizedDescription ?? "error")
                        return
                    }
                    self.pictureView.image = UIImage(data: image)
                }).resume()
                
            }
        }
    }

}

