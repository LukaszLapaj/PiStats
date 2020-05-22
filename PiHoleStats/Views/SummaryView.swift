//
//  SummaryView.swift
//  PiHoleStats
//
//  Created by Fernando Bunn on 10/05/2020.
//  Copyright © 2020 Fernando Bunn. All rights reserved.
//

import SwiftUI


struct SummaryView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var viewModel: PiHoleViewModel
    @EnvironmentObject var preferences: Preferences
    
    var body: some View {
        VStack {
            if viewModel.errorMessage.isEmpty {
                HStack {
                    Circle()
                        .fill(self.viewModel.active ? UIConstants.Colors.active : UIConstants.Colors.offline)
                        .frame(width: UIConstants.Geometry.circleSize, height: UIConstants.Geometry.circleSize)
                    Text(self.viewModel.status)
                    
                    Spacer()
                    
                    if !preferences.apiToken.isEmpty {
                        Button(action: {
                            self.viewModel.active ? self.viewModel.disablePiHole() : self.viewModel.enablePiHole()
                        }) {
                            Text(self.viewModel.changeStatusButtonTitle)
                        }
                    }
                }
                
                Divider()
                
                SummaryItem(value: self.viewModel.totalQueries, type: .totalQuery)
                SummaryItem(value: self.viewModel.queriesBlocked, type: .queryBlocked)
                SummaryItem(value: self.viewModel.percentBlocked, type: .percentBlocked)
                SummaryItem(value: self.viewModel.domainsOnBlocklist, type: .domainsOnBlocklist)
                
            } else {
                Text(viewModel.errorMessage)
                    .multilineTextAlignment(.center)
                if !viewModel.isSettingsEmpty {
                    Button(action: {
                        self.viewModel.resetErrorMessage()
                    }) {
                        Text(UIConstants.Strings.buttonOK)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    NSApplication.shared.terminate(self)
                }) {
                    Text(UIConstants.Strings.buttonQuit)
                }
                
                Spacer()
                
                Button(action: {
                    self.navigationController.openPreferences()
                }) {
                    Text(UIConstants.Strings.buttonPreferences)
                }
            }
            
        }.padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
