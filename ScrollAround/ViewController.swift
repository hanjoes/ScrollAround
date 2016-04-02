//
//  ViewController.swift
//  ScrollAround
//
//  Created by Hanzhou Shi on 4/2/16.
//  Copyright © 2016 Hanzhou Shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Constants
    
    private struct Constants {
        static let NumSubviews = 3
    }

    // MARK: Outlets/Actions
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: Properties
    
    let colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.greenColor()]
    
    var nestedViews = [UIScrollView]()
    
    var pageNum: Int {
        return nestedViews.count
    }
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    // MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize nested Views
        for _ in 0..<Constants.NumSubviews {
            let view = UIScrollView()
            nestedViews.append(view)
        }
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageNum
    }

    override func viewDidLayoutSubviews() {
        let width = mainScrollView.frame.width
        let height = mainScrollView.frame.height
        let size = CGSize(width: width * CGFloat(pageNum), height: height)
        mainScrollView.contentSize = size
        
        for i in 0..<Constants.NumSubviews {
            // inner view is the content for the nested scroll view
            let frame = CGRectMake(CGFloat(i) * width, 0, width, height)
            let innerView = UIView(frame: CGRectMake(0, 0, width, height))
            innerView.backgroundColor = colors[i]
            nestedViews[i].frame = frame
            nestedViews[i].clipsToBounds = false
            nestedViews[i].pagingEnabled = true
            nestedViews[i].directionalLockEnabled = true
            nestedViews[i].addSubview(innerView)
            nestedViews[i].contentSize = CGSize(width: width, height: height * 2)
            mainScrollView.addSubview(nestedViews[i])
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = mainScrollView.contentOffset
        let width = mainScrollView.frame.width
        
        currentPage = Int((offset.x + width / 2) / width)
    }
}

