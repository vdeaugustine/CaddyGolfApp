//
//  AdviceFirstViewModel.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import Foundation

final class AdviceFirstViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var isActive: Bool = false
    @Published var details = DetailsForAdvice()
}
