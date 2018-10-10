//
//  FavResturantVC.swift
//  GoGTest
//
//  Created by mac on 10/7/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import CoreData

class FavResturantVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvListFavPlaces: UITableView!
    var favList = [FavPlaces]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavPlaces()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favresturant", sender: favList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let disFav = segue.destination as? RestaurantFavVC {
            if let RestuFav = sender as? FavPlaces {
                disFav.singleFavSeguItem = RestuFav
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FavPlacesViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavPlacesViewCell
        cell.setCell(favPl: favList[indexPath.row])
        return cell
    }
    
    func loadFavPlaces(){
        let fetchRequest:NSFetchRequest<FavPlaces> = FavPlaces.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username_fk == %@", SigninVC.fkUserName)

        do {
            favList = try context.fetch(fetchRequest)
            tvListFavPlaces.reloadData()
        } catch {
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeFavBu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
