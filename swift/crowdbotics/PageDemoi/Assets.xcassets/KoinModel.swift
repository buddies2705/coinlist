//
//  KoinModel.swift
//  PageDemoi
//
//  Created by Amit Kumar on 19/01/19.
//  Copyright © 2019 Amit Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class KoinModel: NSObject {
    
    var highestBid : String?
    var currencyFullForm : String?
    var lowestAsk : String?
    var tradeVolume : String?
    var currencyShortForm : String?
    var lastTradedPrice : String?


    
    override init() {
        
    }
    
    
    
    init(jsonObject : JSON) {
        
        super.init()
        self.highestBid = jsonObject["highest_bid"].string
        self.currencyFullForm = jsonObject["currency_full_form"].string
        self.lowestAsk = jsonObject["lowest_ask"].string
        self.tradeVolume = jsonObject["trade_volume"].string
        self.currencyShortForm = jsonObject["currency_short_form"].string
        self.lastTradedPrice = jsonObject["last_traded_price"].string

        
    }

}


class finalKoinModel : NSObject {
    var inrList = [KoinModel]()
    var bitcoinList = [KoinModel]()
    var rippleList = [KoinModel]()
    var etherList = [KoinModel]()
    override init() {
     }
    
}
