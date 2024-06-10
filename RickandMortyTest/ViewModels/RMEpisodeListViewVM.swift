//
//  RMEpisodeListViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import UIKit

protocol RMEpisodeListViewVMDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

final class RMEpisodeListViewVM: NSObject {
    
    public weak var delegate: RMEpisodeListViewVMDelegate?
    
    private var isLoadingMoreEpisodes = false

    
    private let borderColors: [UIColor] = [
        .systemRed, .systemBlue, .systemMint, .systemPink, .systemPurple, .systemIndigo
    ]
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes{
                let VM = RMCharacterEpisodeCollectionViewCellVM(episodeDataUrl: URL(string: episode.url), borderColor: borderColors.randomElement() ?? .systemBlue)
                if !cellVM.contains(VM) {
                    cellVM.append(VM)
                }
            }
            
        }
    }
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    private var cellVM : [RMCharacterEpisodeCollectionViewCellVM] = []
    
    func fetchEpisodes() {
        
        let request = RMRequest(endpoint: .episode)
        
        Task{
            do {
                let response: RMGetAllEpisodesResponse = try await RMService.shared.execute(request: request)
                episodes = response.results
                let info = response.info
                apiInfo = info
                delegate?.didLoadInitialEpisodes()

            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchAdditionalEpisodes(url: URL) {
        
        guard !isLoadingMoreEpisodes else {
            return
        }
        isLoadingMoreEpisodes = true
        
        guard let request = RMRequest(url: url) else {
            return
        }
        Task {
            do {
                let response: RMGetAllEpisodesResponse = try await RMService.shared.execute(request: request)
                
                let moreResults = response.results
                
                apiInfo = response.info
                
                let originalCount = episodes.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                episodes.append(contentsOf: moreResults)
                
                delegate?.didLoadMoreEpisodes(with: indexPathToAdd)
                isLoadingMoreEpisodes = false

            } catch {
                print(error.localizedDescription)
                isLoadingMoreEpisodes = false

            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return  apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension RMEpisodeListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.configure(with: cellVM[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("")
        }
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width - 20)
        
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
    }
}

// MARK: - scrollView

extension RMEpisodeListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreEpisodes,
              !cellVM.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else  {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] time in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                self?.fetchAdditionalEpisodes(url: url)
            }
            
            time.invalidate()
        }
    }
}

