//
//  ViewController.swift
//  googlemapSourceAndDestinationDEMO
//
//  Created by CodeInfoWay CodeInfoWay on 3/25/23.
import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {

    @IBOutlet weak var sourceAddTxt: UITextField!
    @IBOutlet weak var destinationAddTxt: UITextField!
    @IBOutlet weak var findbtn: UIButton!
    @IBOutlet weak var sourceAddLbl: UILabel!
    @IBOutlet weak var destinationAddlbl: UILabel!
    @IBOutlet weak var drawRoutebtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findbtnTapped(_ sender: UIButton) {
        guard let sourceAddress = sourceAddTxt.text, let destinationAddress = destinationAddTxt.text else {
            return
        }
        
        getLocation(from: sourceAddress) { (sourceLocation) in
            if let sourceLocation = sourceLocation {
                self.sourceAddLbl.text = "Latitude: \(sourceLocation.latitude), Longitude: \(sourceLocation.longitude)"
            } else {
                self.sourceAddLbl.text = "Location not found"
            }
        }
        getLocation(from: destinationAddress) { (destinationLocation) in
            if let destinationLocation = destinationLocation {
                self.destinationAddlbl.text = "Latitude: \(destinationLocation.latitude), Longitude: \(destinationLocation.longitude)"
            } else {
                self.destinationAddlbl.text = "Location not found"
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
