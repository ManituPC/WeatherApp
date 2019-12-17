import MapKit
import CoreLocation

class LocationService: NSObject {

    var currentLocation = ""
    
    let locationManager = CLLocationManager()
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checklLocationAuthorization()
        } else {
            // TODO: show alert
        }
    }

    func checklLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            currentLocation = getRegion()
        case .denied:
            // show alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // show alert
            break
        case .authorizedAlways:
            break
        }
    }

    func getUserLocation() -> CLLocation {
        let latitude = locationManager.location?.coordinate.latitude ?? 0.0
        let longitude = locationManager.location?.coordinate.longitude ?? 0.0
        let location = CLLocation(latitude: latitude, longitude: longitude)

        return location
    }
    
    func getRegion() -> String {
        var cityName = ""
        let location = getUserLocation()
        let geoCoder = CLGeocoder()
        
        print("******** User location is: \(location) ********")
        
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                // Show alert
                return
            }
            
            guard let placemark = placemarks?.first else {
                // show alert
                return
            }
            
            cityName = placemark.locality ?? "nil"
            print("!!!!!! \(cityName)")
        }
        
        return cityName
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO:
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO:
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[ERROR]: Check your GPS, please!")
    }
}
