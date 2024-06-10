//
//  RMSettingsView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 06/06/2024.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewVM
    
    init(viewModel: RMSettingsViewVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack {
            List(viewModel.cellViewModels) { viewModel in
                HStack {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .renderingMode(.template)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 3))
                            .background(Color(viewModel.iconContainer))
                            .clipShape(.rect(cornerRadius: 6))
                            .foregroundStyle(Color(.white))

                    }
                   
                    Text(viewModel.title).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    Spacer()
                }
                .onTapGesture {
                    viewModel.onTapHandler(viewModel.type)
                }
            }
        }
    }
}

#Preview {
    RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellVM(type: $0) { option in
            
        }
    })))
}
