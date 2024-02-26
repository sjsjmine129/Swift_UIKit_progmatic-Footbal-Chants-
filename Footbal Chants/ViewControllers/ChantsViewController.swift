//
//  ChantsViewController.swift
//  Footbal Chants
//
//  Created by 엄승주 on 2/20/24.
//

import UIKit

class ChantsViewController: UIViewController {

    // MARK -UI
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellId)
        
        return tv
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    private lazy var audioManagerViewModel = AudioManagerViewModel()
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
}

private extension ChantsViewController{
    
    func setup(){
        
        self.navigationController?.navigationBar.topItem?.title = "FootBall Changts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK - UITableViewDataSource
extension ChantsViewController: UITableViewDataSource{
    // num of colunm
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellId, for: indexPath) as! TeamTableViewCell
        cell.configure(with: team, delegate: self)
        return cell
    }
    
}

// MARK - TeamTableViewCellDelegate
extension ChantsViewController: TeamTableViewCellDelegate{
    func didTapPlayback(for team: Team){
        // run audio
        audioManagerViewModel.playback(team)
        
        // change button icon
        teamsViewModel.togglePlayButton(for: team)
        tableView.reloadData()
    }
}
