//
//  TeamTableViewCell.swift
//  Footbal Chants
//
//  Created by 엄승주 on 2/21/24.
//

import UIKit

protocol TeamTableViewCellDelegate:AnyObject{
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    
    static let cellId = "TeamTableViewCell"
    
    // MARK: - UI
    private lazy var containerVw: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var contentStackVw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var badgeImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    
    private lazy var playbackBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
    }()
    
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var foundedLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var jobLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 10, weight: .light)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var infoLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .white
        return lbl
    }()
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerVw.layer.cornerRadius = 10
    }
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //  remove team & delegate
        self.team = nil
        self.delegate = nil
        
        //delete ui of not seen
        self.containerVw.subviews.forEach {$0.removeFromSuperview()}
    }
    
    // make each cell
    func configure(with item: Team, delegate: TeamTableViewCellDelegate){
        
        self.team = item
        self.delegate = delegate
        
        playbackBtn.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)
        
        containerVw.backgroundColor = item.id.background
        
        badgeImgVw.image = item.id.badge
        playbackBtn.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        
        nameLbl.text = item.name
        foundedLbl.text = item.founded
        jobLbl.text = "Current \(item.manager.job.rawValue): \(item.manager.name)"
        infoLbl.text = item.info
        
        self.contentView.addSubview(containerVw)
        
        containerVw.addSubview(contentStackVw)
        
        containerVw.addSubview(badgeImgVw)
        containerVw.addSubview(playbackBtn)
        
        contentStackVw.addArrangedSubview(nameLbl)
        contentStackVw.addArrangedSubview(foundedLbl)
        contentStackVw.addArrangedSubview(jobLbl)
        contentStackVw.addArrangedSubview(infoLbl)
        
        NSLayoutConstraint.activate([
            containerVw.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 8),
            containerVw.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  -8),
            containerVw.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 8),
            containerVw.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -8),
            
            badgeImgVw.heightAnchor.constraint(equalToConstant: 50),
            badgeImgVw.widthAnchor.constraint(equalToConstant: 50),
            badgeImgVw.topAnchor.constraint(equalTo: contentStackVw.topAnchor),
            badgeImgVw.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8),
            
            contentStackVw.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 16),
            contentStackVw.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -16),
            contentStackVw.leadingAnchor.constraint(equalTo: badgeImgVw.trailingAnchor, constant: 8),
            contentStackVw.trailingAnchor.constraint(equalTo: playbackBtn.leadingAnchor, constant: -8),
            
            playbackBtn.heightAnchor.constraint(equalToConstant: 44),
            playbackBtn.widthAnchor.constraint(equalToConstant: 44),
            playbackBtn.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8),
            playbackBtn.centerYAnchor.constraint(equalTo: containerVw.centerYAnchor),
            
        ])
    }
    
    //send team data to ViewconTrollers function
    @objc func didTapPlayback(){
        if let team = team{
            delegate?.didTapPlayback(for: team)
        }
    }
}
