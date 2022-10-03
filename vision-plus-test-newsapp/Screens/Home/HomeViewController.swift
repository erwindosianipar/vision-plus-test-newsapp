//
//  HomeViewController.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit
import RxSwift

internal final class HomeViewController: ViewController {
    
    // MARK: - UI Properties
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout.getLayout(type: .news)).then {
            $0.register(cell: NewsCardCollectionViewCell.self)
            $0.backgroundColor = .white
            $0.delegate = self
            $0.dataSource = self
        }
    
    // MARK: - HomeViewController Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: HomeViewModel?
    private var loading: Bool = true
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupLargeTitleAndSearchView() {
        self.title = "News App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupView() {
        setupLargeTitleAndSearchView()
        self.view.addSubviews(
            collectionView
        )
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        fetchAPI()
    }
    
    private func fetchAPI() {
        self.loading = true
        self.viewModel?.articles()
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] response in
                if response.isEmpty {
                    self?.showAlert(title: "Error", message: "Data Not Found", action: nil)
                    return
                }
                self?.loading.toggle()
                self?.viewModel?.news = response
                self?.collectionView.reloadData()
            },
            onError: { [weak self] error in
                self?.loading.toggle()
                self?.viewModel?.news = []
                self?.checkInternetConnection(error: error, action: {
                    self?.fetchAPI()
                })
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let news = self.viewModel?.news else {
            return
        }
        self.navigationEvent.send(.next(news[indexPath.row]))
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let news = self.viewModel?.news else {
            return 0
        }
        return loading ? 5 : news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = self.viewModel?.news {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cell: NewsCardCollectionViewCell.self)
            if loading {
                return cell
            }
            cell.configure(data: model[indexPath.row], completion: {
                cell.setNeedsLayout()
            })
            return cell
        }
        return UICollectionViewCell()
    }
}
