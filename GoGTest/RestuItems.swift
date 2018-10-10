//
//  RestuItems.swift
//  GoGTest
//
//  Created by mac on 10/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class RestuItems {
    var placeName:String?
    var openNow:String?
    var  imgRestu:String?
    var addresGemLang:String?
    var addresGemLat:String?
    var typeR:String?
    var rateG:String?

    init(PlName:String,OpenN:String,ImgRestu:String,Lang:String,Lat:String,TypeR:String,Rate:String) {
        self.placeName=PlName
        self.openNow = OpenN
        self.imgRestu = ImgRestu
        self.addresGemLang = Lang
        self.addresGemLat = Lat
        self.typeR = TypeR
        self.rateG = Rate
    }
    
    
}
