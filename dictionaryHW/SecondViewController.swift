//
//  SecondViewController.swift
//  dictionaryHW
//
//  Created by Olzhas Zhakan on 18.08.2023.
//
//
import Foundation
import UIKit
import SnapKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var historyArray: [String] = []
 
    let table: UITableView = {
        let table = UITableView()
       return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = historyArray[indexPath.row]
        return cell
    }
}
