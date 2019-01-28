//
//  ViewController.swift
//  PageDemoi
//
//  Created by Amit Kumar on 18/01/19.
//  Copyright © 2019 Amit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.getKoinData()
    
    }
    
    
    func getKoinData(){
        
        
        ServiceManager.getRequestWithFullUrl("https://koinex.in/api/ticker", success: { (responseObject) in
            print(responseObject)
            let inrList = responseObject["stats"]["inr"].map { return $1}
            let  bitcoinList = responseObject["stats"]["bitcoin"].map { return $1}
            let rippleList = responseObject["stats"]["ripple"].map { return $1}
            let etherList = responseObject["stats"]["ether"].map { return $1}
            
            
            let inrModelList = inrList.map { KoinModel(jsonObject : $0) }
            let bitcoinModelList = bitcoinList.map { KoinModel(jsonObject : $0) }
            let rippleModelList = rippleList.map { KoinModel(jsonObject : $0) }
            let etherModelList = etherList.map { KoinModel(jsonObject : $0) }
            
            
            let koinModelObject = finalKoinModel()
            koinModelObject.inrList = inrModelList
            koinModelObject.bitcoinList = bitcoinModelList
            koinModelObject.rippleList = rippleModelList
            koinModelObject.etherList = etherModelList
            
            appDelegateObj().finalModelObject = koinModelObject
            
            appDelegateObj().mainRootView()
            
        }) { (errorObject) in
            print(errorObject)
        }
        
    }
    
    
    


}

