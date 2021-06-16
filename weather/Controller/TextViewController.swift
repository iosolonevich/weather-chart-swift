//
//  TextViewController.swift
//  weather
//
//  Created by alex on 13.06.2021.
//

import UIKit

class TextViewController: UIViewController {

    private var fileName: String
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .never
        return textView
    }()
    
    init(fileName: String) {
        self.fileName = fileName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        
        // load RTF-file
        let url = Bundle.main.url(forResource: fileName, withExtension: "rtf")!
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf]
        let rtfString = try! NSMutableAttributedString(url: url, options: options, documentAttributes: nil)

        // apply to label
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.attributedText = rtfString
        
        textView.attributedText = rtfString
        
        view.addSubview(textView, anchors: [ .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor), .top(view.topAnchor, 55) ])
        
        }

}
