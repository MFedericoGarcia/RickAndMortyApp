//
//  RMCharacterDetailVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 20/05/2024.
//

import UIKit

class RMCharacterDetailVC: UIViewController{
    
    private var viewModel: RMCharacterDetailViewVM
    private let detailView: RMCharacterDetailView
    
    init(viewModel: RMCharacterDetailViewVM){
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        detailView.collectionView.delegate = self
        detailView.collectionView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc
    private func didTapShare(){
    }
    
    
    
}

extension RMCharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
            
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
            
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .systemTeal
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
            
        case .photo:
            return 1
        case .information(viewModels: let viewModel):
            return viewModel.count
        case .episodes(viewModels: let viewModel):
            return viewModel.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            
        case .photo, .information:
            break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
                
            let vc = RMEpisodeDetailVC(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
