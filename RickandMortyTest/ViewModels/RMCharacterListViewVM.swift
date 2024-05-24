//
//  CharacterListViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

protocol RMCharacterListViewVMDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewVM: NSObject {
    
    public weak var delegate: RMCharacterListViewVMDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters{
                let VM = RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
                if !cellVM.contains(VM) {
                    cellVM.append(VM)
                }
            }
            
        }
    }
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    private var cellVM : [RMCharacterCollectionViewCellVM] = []
    
    func fetchCharacters() {
        
        let request = RMRequest(endpoint: .character)
        
        Task{
            do {
                let response: RMGetAllCharactersResponse = try await RMService.shared.execute(request: request)
                characters = response.results
                let info = response.info
                apiInfo = info
                delegate?.didLoadInitialCharacters()

            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchAdditionalCharacters(url: URL) {
        
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url) else {
            return
        }
        Task {
            do {
                let response: RMGetAllCharactersResponse = try await RMService.shared.execute(request: request)
                
                let moreResults = response.results
                
                apiInfo = response.info
                
                let originalCount = characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                characters.append(contentsOf: moreResults)
                
                delegate?.didLoadMoreCharacters(with: indexPathToAdd)
                isLoadingMoreCharacters = false

            } catch {
                print(error.localizedDescription)
                isLoadingMoreCharacters = false

            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return  apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension RMCharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            
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
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - scrollView

extension RMCharacterListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
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
                self?.fetchAdditionalCharacters(url: url)
            }
            
            time.invalidate()
        }
    }
}
