//
//  PopUpHistoryViewController.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 27/03/2023.
//
//  Overlay window to view the history any time.
import UIKit

class PopUpHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    
    struct History{
        let title: String
        let option: String
    }
    //var data: [History] = []
    
    var data = HistoryModel.shared.data
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 170
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.title.text = history.title
        cell.option.text = history.option
        
        return cell
    }
   

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
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
