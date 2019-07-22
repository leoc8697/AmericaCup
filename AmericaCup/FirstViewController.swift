//
//  FirstViewController.swift
//  AmericaCup
//
//  Created by David Leon on 7/12/19.
//  Copyright © 2019 David Leon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var labelHeader: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
   
    var movieList = [MarvelData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource: "response", withExtension: "json")
        
        guard let jsonData = url
            else{
                print("data not found")
                return
        }
        
        guard let data = try? Data(contentsOf: jsonData) else { return }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return}
        
        if let dictionary = json as? [String: Any] {
            
            if let title = dictionary["title"] as? String {
                labelHeader.text = title
            }
            
            if let year = dictionary["year"] as? Double {
                print("Year is \(year)")
            }
            if let more_info = dictionary["more_info"] as? Double {
                //This doesn't get printed.
                print("More_info is \(more_info)")
            }
            
            for (key, value) in dictionary {
                print("Key is: \(key) and value is \(value)" )
            }
            
        }
        
        //Now lets populate our TableView
        let newUrl = Bundle.main.url(forResource: "marvel", withExtension: "json")
        
        guard let j = newUrl
            else{
                print("data not found")
                return
        }
        
        guard let d = try? Data(contentsOf: j)
            else { print("failed")
                return
                
        }
        
        guard let rootJSON = try? JSONSerialization.jsonObject(with: d, options: [])
            else{ print("failedh")
                return
                
        }
        
        if let JSON = rootJSON as? [String: Any] {
            labelHeader.text = JSON["title"] as? String
            
            guard let jsonArray = JSON["movies"] as? [[String: Any]] else {
                return
            }
            
            print(jsonArray)
            let name = jsonArray[0]["name"] as? String
            print(name ?? "NA")
            print(jsonArray.last!["year"] as? Int ?? 1970)
            
            movieList = jsonArray.compactMap{return MarvelData($0)}
            
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = currentMovie.movieName
        cell.detailTextLabel?.text = "\(currentMovie.movieYear)"
        return cell
    }
    
}


struct MarvelData {
    var movieName: String
    var movieYear: Int
    init(_ dictionary: [String: Any]) {
        self.movieName = dictionary["name"] as? String ?? "NA"
        self.movieYear = dictionary["year"] as? Int ?? 1970
    }
}


