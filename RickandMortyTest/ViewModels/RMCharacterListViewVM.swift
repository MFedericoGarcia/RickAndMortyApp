//
//  CharacterListViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

protocol RMCharacterListViewVMDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewVM: NSObject {
    
    public weak var delegate: RMCharacterListViewVMDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let VM = RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
                cellVM.append(VM)
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
        print(characters)
    }
    
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
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
        guard shouldShowLoadMoreIndicator else {
            return
        }
    }
}
