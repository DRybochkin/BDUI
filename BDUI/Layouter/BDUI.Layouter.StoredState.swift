//
//  BDUI.Layouter.StoredState.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 03.03.2025.
//

import Foundation

extension BDUI.Layouter {
    
    struct StoredState: Equatable {
        
        // MARK: - Properties
        
        let frame: CGRect
        let frameWithPadding: CGRect
        let insets: BDUI.Layout.EdgeInsets
        
        // MARK: - Initializations
        
        init(frame: CGRect, frameWithPadding: CGRect, insets: BDUI.Layout.EdgeInsets) {
            self.frame = frame
            self.frameWithPadding = frameWithPadding
            self.insets = insets
        }
        
        init(state: StoredState, frame: CGRect? = nil, frameWithPadding: CGRect? = nil, insets: BDUI.Layout.EdgeInsets? = nil) {
            self.frame = frame ?? state.frame
            self.frameWithPadding = frameWithPadding ?? state.frameWithPadding
            self.insets = insets ?? state.insets
        }
    }
}
