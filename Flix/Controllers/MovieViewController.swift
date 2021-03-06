//
//  ViewController.swift
//  Flix
//
//  Created by Eyoel Wendwosen on 2/25/22.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!

    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    // TODO: Store the movies in a property to use elsewhere
                    print(self.movies)
                    // TODO: Reload your table view data
                 self.tableView.reloadData()
             }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af.setImage(withURL: posterUrl)
        
        cell.titleLabel?.text = title
        cell.synopsisLabel?.text = synopsis
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // find the cell that got selected
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // get the view controller through the segue way and pass the detilas needed. 
        let destinationViewController = segue.destination as! MovieDetailViewController
        destinationViewController.movie = movie
        
        // remvoe highlighting from the selected row when the page tranistions
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

