//
//  MapLocVC.swift
//  GoGTest
//
//  Created by mac on 10/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import MapKit
class customPin: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
     init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
class MapLocVC: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nav: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sourceLoc = CLLocationCoordinate2D(latitude: 30.0559289, longitude: 31.2063334)
        let destinationLoc = CLLocationCoordinate2D(latitude: 30.0412573, longitude: 31.185531 )
        let sourcePin = customPin(pinTitle: "start", pinSubTitle: "", location: sourceLoc)
        let destPin = customPin(pinTitle: "end", pinSubTitle: "", location: destinationLoc)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destPin)
        let sourceMarkPlace = MKPlacemark(coordinate: sourceLoc)
        let destMarkPlace = MKPlacemark(coordinate: destinationLoc)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourceMarkPlace)
        directionRequest.destination = MKMapItem(placemark: destMarkPlace)
        directionRequest.transportType = .automobile
        let direction = MKDirections(request: directionRequest)
        direction.calculate { (resonse,error) in
            guard let directionRespone = resonse else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            let route = directionRespone.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
          //  self.mapView.addOverlays(route.polyline, level: <#T##MKOverlayLevel#>)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
            self.mapView.delegate = self
        view.addSubview(nav)
        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
        render.lineWidth = 4.0
        return render
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
