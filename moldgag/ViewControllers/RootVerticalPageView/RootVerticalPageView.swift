//
//  RootVerticalPageView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import NIO
import GRPC
import UIKit
import MediaPlayer

// url to example with download data for video
// https://github.com/2ZGroupSolutionsArticles/Article_EZ002/blob/master/DownloadMediaDemo/DownloadMediaDemo/ViewControllers/SimpleExportViewController.swift

// load mp4 byte by byte
// https://jaredsinclair.com/2016/09/03/implementing-avassetresourceload.html
// https://github.com/jaredsinclair/sodes-audio-example/blob/master/Sodes/SodesExample/ViewController.swift

//  caching while plaiyng video
// https://github.com/2ZGroupSolutionsArticles/Article_EZ002


// video scrubbing
// https://gist.github.com/freshking/eccd41361edd9381a81bbeccce3a97fb

///  RootVerticalPageViewController -
class RootVerticalPageView: UIPageViewController {
    
    private let viewModel: RootVerticalPageViewModel
        
    var initialOffset: CGPoint = .zero
            
//    var heightConstraint: NSLayoutConstraint!
    
//    var hei: CGFloat = 0
    
    init(viewModel: RootVerticalPageViewModel = .init(moldgagVideoService: try! MoldgagVideoServiceImpl())) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    
        self.delegate = self
        self.dataSource = self
        
        let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        initialOffset = scrollView.contentOffset
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = .init(moldgagVideoService: try! MoldgagVideoServiceImpl())
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        
        self.delegate = self
        self.dataSource = self
        
        let scrollView = view.subviews.filter { $0 is UIScrollView }.last as! UIScrollView
        scrollView.delegate = self
        initialOffset = scrollView.contentOffset
    }
}

extension RootVerticalPageView {
    
    override var prefersStatusBarHidden: Bool {
        return UIDevice.current.hasNotch ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        
        let loadingVC = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        self.setViewControllers([loadingVC], direction: .forward, animated: true, completion: nil)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75)
        let label = UILabel(frame: frame)
        label.text = "Pull to refresh ..."
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .yellow
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
//        label.backgroundColor = .red

//        label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(label, at: 0)
//        view.addSubview(label)
//
//
//        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        heightConstraint = label.heightAnchor.constraint(equalToConstant: 100)
//        heightConstraint.isActive = true

//        label.heightAnchor.constraint(equalTo: label.widthAnchor).isActive = true
//        label.layoutIfNeeded()

        
        viewModel.updateViewController { vc in
            DispatchQueue.main.async {
                self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
            }
        }
        
        
        
    }
}

extension RootVerticalPageView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let scaleFactor = 1 + ((1 - (scrollView.contentOffset.y / initialOffset.y)) * 2)
//        print(scrollView.contentOffset.y / initialOffset.y)
        
//        let val = 100 + ((scrollView.contentOffset.y / self.initialOffset.y) * 100)
//        print(val)
//        self.heightConstraint.constant = val


        
//        self.heightConstraint.constant = 200 * ((scrollView.contentOffset.y / self.initialOffset.y) * 5)
//        self.view.layoutIfNeeded()
        
//        hei = 50 + ((scrollView.contentOffset.y / initialOffset.y) * 5)
        
        guard !viewModel.isLoading, viewModel.currentIndex == 0,
              scrollView.contentOffset.y < (UIScreen.main.bounds.height * 0.80) else { return }
        
        print("refresh")
        
        
        viewModel.isLoading = true
        scrollView.isScrollEnabled = false
        
        // disable pan
        scrollView.panGestureRecognizer.isEnabled = false
        
        // scroll to initial
        scrollView.setContentOffset(self.initialOffset, animated: true)
        
        // on completion enable scroll
        scrollView.panGestureRecognizer.isEnabled = true
        
        self.setViewControllers([LoadingView()], direction: .forward, animated: true) { _ in
            self.viewModel.refresh()
            scrollView.isScrollEnabled = true
        }
    }
}

extension RootVerticalPageView: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            viewModel.updateCurrentIndex(for: pageViewController.viewControllers?.first)
        }
    }
}

extension RootVerticalPageView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerBefore()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerAfter()
    }
}
