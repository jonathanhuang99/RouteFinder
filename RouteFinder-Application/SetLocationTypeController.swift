//
//  SetLocationTypeController.swift
//  RouteFinder-Application
//
//  Created by Daniel Vu on 3/8/20.
//  Copyright © 2020 UC Irvine. All rights reserved.
//

import UIKit

class SetLocationTypeController: UIViewController, LocationTypeCellDelegate, UITableViewDelegate, UITableViewDataSource {
    var loveStatus : [Bool] = []
    
    func didTapHeart(isLoved: Bool, cellIndex : Int) {
        loveStatus[cellIndex] = isLoved
        UserDefaults.standard.set(loveStatus, forKey: "LOCATION_TYPE_LOVE")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LOCATION_TYPE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationTypeCell", for: indexPath) as! LocationTypeCell
        
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.LocationTypeOutlet.layer.masksToBounds = true
        cell.LocationTypeOutlet.layer.cornerRadius = 8.0
        
        if loveStatus[indexPath.row] {
            cell.HeartOutlet.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            cell.isLoved = true
        }
        else {
            cell.HeartOutlet.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            cell.isLoved = false
        }
            
        var newString = LOCATION_TYPE[indexPath.row].replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        newString = newString.replacingOccurrences(of: " or ", with: " / ", options: .literal, range: nil)
        cell.LocationTypeOutlet.text = newString
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let x = UserDefaults.standard.object(forKey: "LOCATION_TYPE_LOVE") as? [Bool] {
            loveStatus = x
        }
        
        tableView.delegate = self
        tableView.reloadData()
    }

}
