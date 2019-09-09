//
//  EmeraldTextField+ViewStatus.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 6/27/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

extension EmeraldTextField {
    public func setStatus(_ status: EmeraldTextFieldState) {
        self.fieldState = status
        switch status {
        case .valid:
            addCheckMark()
        case .normal:
            removeRightView()
        case .loading:
            addActivityIndicator()
        case .error:
            addErrorIcon()
            break
        }
    }
    
    public var status: EmeraldTextFieldState {
        return fieldState
    }
}

extension EmeraldTextField {
    private func addCheckMark() {
        addIconImage(with: "icon_complete.png")
    }
    
    private func addErrorIcon() {
        addIconImage(with: "icon_error.png")
    }
    
    private func addIconImage(with name: String) {
        let rightButtonView = UIImageView(frame: CGRect(x: 0.0,
                                                        y: 0.0,
                                                        width: ((self.frame.height) * 0.48),
                                                        height: ((self.frame.height) * 0.35)))
        rightButtonView.image = UIImage(named: name,
                                        in: Bundle(for: ClassBundle.self),
                                        compatibleWith: nil)
        rightButtonView.contentMode = .scaleAspectFit
        self.addRightView(with: rightButtonView)
    }
    
    private func addActivityIndicator() {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.startAnimating()
        self.addRightView(with: activity)
    }
    
    func addRightView(with childView: UIView, x: CGFloat = 0.0) {
        let containerView: UIView = UIView(frame: CGRect(x: x,
                                                         y: 0.0,
                                                         width: self.frame.height,
                                                         height: self.frame.height))
        containerView.addSubview(childView)
        childView.center = containerView.center
        self.rightView = containerView
        self.rightViewMode = .always
    }
    
    private func removeRightView() {
        self.rightView = nil
        self.rightViewMode = .never
    }
}
