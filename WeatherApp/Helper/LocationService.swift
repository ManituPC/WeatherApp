import CoreLocation
import MapKit

class LocationService: NSObject {

    var currentLocation: String?
    
    var coordinate: CLLocation?
    
    var authorizeStatusDidChange: (() -> ())?
    
    let locationManager = CLLocationManager()
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            //checklLocationAuthorization()
        } else {
            // TODO: show alert
        }
    }

    func checklLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            currentLocation = getRegion()
//        case .denied:
//            // show alert
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // show alert
//            break
//        case .authorizedAlways:
//            break
//        }
    }

    func getUserLocation() -> CLLocation {
        let latitude = locationManager.location?.coordinate.latitude ?? 0.0
        let longitude = locationManager.location?.coordinate.longitude ?? 0.0
        let location = CLLocation(latitude: latitude, longitude: longitude)

        return location
    }
    
    func getRegion(location: CLLocation) -> String? {
        var cityName: String?
        let geoCoder = CLGeocoder()
        
        print("1) !!!!! User location is: \(location)\n********")
        
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            
            print("2) !!!!!!! in reverseGeocodeLocation() method")
            guard self != nil else { return }

            if let _ = error {
                // Show alert
                return
            }

            guard let placemark = placemarks?.first else {
                // show alert
                return
            }

            if let name = placemark.locality {
                cityName = name
                
                print("!!!!!! cityName = \(cityName)")
            }
        }
        
        print("##### cityName = \(cityName)")

        return cityName
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        authorizeStatusDidChange?()

        if let newLocation = locations.last {
            self.coordinate = newLocation
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //authorizeStatusDidChange?()
        print("!!!!!! didChangeAuthorization")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[ERROR]: Check your GPS, please!")
    }
}
