//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Eyoel Wendwosen on 3/4/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    var movie: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movie["title"] as? String
        movieSynopsisLabel.text = movie["overview"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/"
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + "w185/\(posterPath)")!
        posterImageView.af.setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: baseUrl + "w780\(backdropPath)")!
        backdropImageView.af.setImage(withURL: backdropUrl)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
