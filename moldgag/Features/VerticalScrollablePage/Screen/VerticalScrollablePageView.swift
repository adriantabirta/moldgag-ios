//
//  VerticalScrollablePageView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import Combine
import Resolver
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
class VerticalScrollablePageView: UIPageViewController {
    
    // MARK: - Dependencies
    
    @Injected var viewModel: VerticalScrollablePageViewModel
    
    // MARK: - Proprieties
    
    private var audioSessionVolumeMonitor = AudioSessionVolumeMonitor()
    
    weak var coordinator: VerticalScrollablePageCoordinator?
    
    var initialOffset: CGPoint = .zero
    
    private var volumeProgressBar = ProgressBar()
    
    private var bag = Set<AnyCancellable>()
    
    var pullToRefreshLable: UILabel = {
        //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 75))
        $0.text = "Pull to refresh ..."
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .yellow
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        return $0
    }(UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)))
    
    //    var heightConstraint: NSLayoutConstraint!
    
    //    var hei: CGFloat = 0
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        
        self.delegate = self
        self.dataSource = self
        
        let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        initialOffset = scrollView.contentOffset
        
        viewModel.$firstViewControllerPublished
            .receive(on: DispatchQueue.main)
            .sink { vc in
                self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
            }.store(in: &bag)
        
        audioSessionVolumeMonitor.volume
            .removeDuplicates()
            .print()
            .assign(to: \.progressWithFadeAnimation, on: volumeProgressBar).store(in: &bag)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        
        self.delegate = self
        self.dataSource = self
        
        let scrollView = view.subviews.filter { $0 is UIScrollView }.last as! UIScrollView
        scrollView.delegate = self
        initialOffset = scrollView.contentOffset
        
        viewModel.$firstViewControllerPublished
            .receive(on: DispatchQueue.main)
            .sink { vc in
                self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
            }.store(in: &bag)
        
        audioSessionVolumeMonitor.volume
            .removeDuplicates()
            .print()
            .assign(to: \.progressWithFadeAnimation, on: volumeProgressBar).store(in: &bag)
    }
}

extension VerticalScrollablePageView {
    
    override var prefersStatusBarHidden: Bool {
        return false // UIDevice.current.hasNotch ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
//        let loadingVC = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
//        self.setViewControllers([loadingVC], direction: .forward, animated: true, completion: nil)
        
        //        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75)
        //        let label = UILabel(frame: frame)
        //        label.text = "Pull to refresh ..."
        //        label.font = .systemFont(ofSize: 25, weight: .bold)
        //        label.textAlignment = .center
        //        label.numberOfLines = 0
        //        label.textColor = .yellow
        //        label.adjustsFontSizeToFitWidth = true
        //        label.minimumScaleFactor = 0.5
        //        label.backgroundColor = .red
        
        //        label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(pullToRefreshLable, at: 0)
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
        
        
        

        
        // add progress bar
        volumeProgressBar.translatesAutoresizingMaskIntoConstraints = false
        volumeProgressBar.color = .random()
        view.addSubview(volumeProgressBar)
        
        volumeProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        volumeProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        volumeProgressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3).isActive = true
        volumeProgressBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//         viewModel.loadFirstPage()
    }
}

extension VerticalScrollablePageView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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

extension VerticalScrollablePageView: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = viewModel.firstViewController(), !pendingViewControllers.contains(vc) {
            pullToRefreshLable.alpha =  0.0
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            viewModel.updateCurrentIndex(for: pageViewController.viewControllers?.first)
            
            pullToRefreshLable.alpha = viewModel.currentIndex == 0 ? 1.0 : 0.0
        }
    }
}

extension VerticalScrollablePageView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerBefore()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.viewControllerAfter()
    }
}
