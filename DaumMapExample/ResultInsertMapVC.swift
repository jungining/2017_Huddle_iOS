//
//  ResultInsertMapVC.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 6..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit

class ResultInsertMapVC: UIViewController, MTMapViewDelegate {
    private let daumAPIKey = "989e84a4ef34f3f5247eab3c943f132d" // replace with your Daum API Key
    
    var selectedPosition : [Position]?
    
    @IBOutlet var mapView : MTMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.daumMapApiKey = daumAPIKey
        mapView.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func putPoiItem(){
        mapView.baseMapType = .standard
        // items.append(poiItem(name: "넷", latitude: 126, longitude: 38))
        // items.append(poiItem(name: "넷", latitude: 127.1722, longitude: 37.5665))
        // items.append(poiItem(name: "넷", latitude: 126.920757, longitude: 37.623885))
        // items.append(poiItem(name: "넷", latitude: 126.927032, longitude: 37.4873488))
        
        
        //        //샘플 데이터
        //        selectedPosition = Position(place: "여기", longtitude: "127.0426469", latitude: "37.5037539")
        
        
        var items = [MTMapPOIItem]()
        
        
        if let mySelectedPosition = selectedPosition{
            for sp in mySelectedPosition{
                 items.append(
                    poiItem(
                        //gdno extensionControl에 추가!
                        name: gsno(sp.place),
                        latitude:  gdno(sp.longtitude),
                        longitude:  gdno(sp.latitude)
                ))
            }
            
        }
        
        mapView.addPOIItems(items)
        mapView.fitAreaToShowAllPOIItems()
        self.view.insertSubview(mapView, at: 0)
        
    }
    
    
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.draggable = false
        item.markerType = .redPin
        item.markerSelectedType = .bluePin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .noAnimation
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
    }
}
