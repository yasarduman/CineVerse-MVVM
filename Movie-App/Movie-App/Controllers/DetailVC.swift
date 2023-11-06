//
//  DetailVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 4.11.2023.
//

import UIKit

class DetailVC: UIViewController {
    // MARK: - Header View
    private var headerView = DetailUIView()
    
    // MARK: - TableView
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    lazy var movie: Movie? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        configureTableView()
        configureHeaderView()
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.frame = view.frame
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Güvenli alanın altındaki boşluğu hesaplayın
        let safeAreaBottom = view.safeAreaInsets.bottom
        //SafeAreaKadar Boşluk bıraktık
        homeFeedTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0)
    
    }
    
    // MARK: - Configure HeaderView
    private func configureHeaderView() {
        headerView = DetailUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
    }
    
    
    private func configureTableView() {
   
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
       
        homeFeedTable.backgroundColor = .tertiarySystemGroupedBackground
        homeFeedTable.contentInsetAdjustmentBehavior = .never
        
   
    }

}

extension DetailVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .green
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "sectionTitles[section]"
    }
    
    
    
}

#Preview{
    DetailVC()
}
