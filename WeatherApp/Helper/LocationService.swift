
import CoreLocation

class LocationService {

    let locationManager = CLLocationManager()

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationServices() {
        if CLLocationManger.locationServicesEnabled() {
            setupLocationManager()
            checklLocationAuthorization() // TODO: add option to Info.plist
        } else {
            // TODO: show alert
        }
    }

    func checklLocationAuthorization() {
        switch CLLocationManager.authorizationStatus {
        case .authorizedWhenInUsed:
            // do map stuff
            break
        case .denied:
            // show alert
            break
        case .notDetermined:
            locationManager.requestWhemInUseAuthorization()
        case .restricted:
            // show alert
            break
        case .authorizedAlways:
            break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO:
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO:
    }
}