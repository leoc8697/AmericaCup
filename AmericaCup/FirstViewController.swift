//
//  FirstViewController.swift
//  AmericaCup
//
//  Created by David Leon on 7/12/19.
//  Copyright © 2019 David Leon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
       
    var movieList = [MatchData]()
    
    
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
            
            movieList = jsonArray.compactMap{return MatchData($0)}
            
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


struct MatchData {
    var team1Name: String
    var team2Name: String
    var score: String
    var dateMatch: String
    init(_ dictionary: [String: Any]) {
        self.team1Name = dictionary["team1"] as? String ?? "NA1"
        self.team2Name = dictionary["team2"] as? String ?? "NA2"
        self.score = dictionary["score"] as? String ?? "0 - 0"
        self.dateMatch = dictionary["dateMatch"] as? String ?? "dd/mm/aa"
    }
}


