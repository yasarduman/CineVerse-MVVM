//
//  SwitchTableViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor =  MovieColor.playButonBG
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = MovieColor.goldColor
        return mySwitch
    }()
    
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        // UserDefaults veya başka bir ayar mekanizması ile Dark Mode durumunu kontrol edin
        mySwitch.addTarget(self, action: #selector(darkModeSwitchValueChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func darkModeSwitchValueChanged(_ sender: UISwitch) {
      
    }

   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        mySwitch.sizeToFit()
        let mySwitchwidth: CGFloat = mySwitch.frame.size.width
        let mySwitchheight: CGFloat = mySwitch.frame.size.height
        
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.anchor(leading: leadingAnchor,
                             padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                             size: .init(width: size, height: size)
        )
        iconContainer.centerYInSuperview()
        
        iconImageView.anchor(size: .init(width: imageSize, height: imageSize))
        iconImageView.centerXInSuperview()
        iconImageView.centerYInSuperview()
        
        label.anchor(leading: iconContainer.trailingAnchor,
                     padding: .init(top: 0, left: 20, bottom: 0, right: 0)
        )
        label.centerYInSuperview()
        
        mySwitch.anchor(trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                        size: .init(width: mySwitchwidth, height: mySwitchheight)
        )
        mySwitch.centerYInSuperview()
        
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        mySwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption){
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgrondColor
        mySwitch.isOn = model.isOn
    }
    
    
}
