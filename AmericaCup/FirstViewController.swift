//
//  FirstViewController.swift
//  AmericaCup
//
//  Created by David Leon on 7/12/19.
//  Copyright © 2019 David Leon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,URLSessionDelegate {
    
    
    
    @IBOutlet var collectionViewMain: UICollectionView!
        //@IBOutlet var floatButtonScanner: UIButton!
        let jsonUrlString = "https://api.myjson.com/bins/gaenp"
        
        var partidosServices: PartidoServiceProtocol = PartidoService()
        lazy var partidos:[Partido] = []
        /*
        override func viewDidLoad() {
            super.viewDidLoad()
            floatButtonScanner.layer.cornerRadius = floatButtonScanner.frame.height/2
            loadPlaces()
        }*/
        
        func loadPartidos() {
            partidosServices.getPartido(with: jsonUrlString) {
                (listPartidos, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let listPartidos = listPartidos{
                    print("=======================================")
                    print(listPartidos)
                    self.partidos = listPartidos
                    self.agregarImg()
                }
            }
        }
        
        func agregarImg() {
            for index in 0...(partidos.count-1){
                partidosServices.getImagePartido(with: partidos[index].urlFlagTeam1!) {
                    (img, error) in
                    if error != nil { // Deal with error here
                        print("error")
                        return
                    }else if let img = img{
                        self.partidos[index].flagTeam1 = img
                    }
                    //self.collectionViewMain.reloadData()
                }
                partidosServices.getImagePartido(with: partidos[index].urlFlagTeam2!) {
                    (img, error) in
                    if error != nil { // Deal with error here
                        print("error")
                        return
                    }else if let img = img{
                        self.partidos[index].flagTeam2 = img
                    }
                    self.collectionViewMain.reloadData()
                }
                
            }
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return partidos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "celdaMain", for: indexPath) as! MainCollectionViewCell
            cell.team1.text = partidos[indexPath.item].team1
            cell.team2.text = partidos[indexPath.item].team2
            cell.score.text = partidos[indexPath.item].score
            cell.dateMatch.text = partidos[indexPath.item].dateMatch
            cell.imgTeam1.image = partidos[indexPath.item].flagTeam1
            cell.imgTeam2.image = partidos[indexPath.item].flagTeam2
            print("para cada imagen",partidos[indexPath.item].flagTeam1)
            return cell
        }
        /*
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let item = sender as? UICollectionViewCell,
                let indexPath = collectionViewMain.indexPath(for: item),
                let detailVC = segue.destination as? DetailViewController{
                // detailVC.place = places[indexPath.item]
            }
        }*/

}
