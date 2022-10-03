//
//  DetailViewController.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

internal final class DetailViewController: ViewController {
    
    // MARK: - UI Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
    }
    private let contributorNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    private let createdAtLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 10
    }
    private lazy var slideshowCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout.getLayout(type: .slideshow)).then {
            $0.register(cell: SlideshowCollectionViewCell.self)
            $0.backgroundColor = .white
            $0.dataSource = self
        }
    private let contentLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    // MARK: - DetailViewController Properties
    
    var viewModel: DetailViewModel?
    
    init(viewModel: DetailViewModel) {
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
    
    private func setupView() {
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        stackView.addArrangedSubview(contributorNameLabel)
        stackView.setCustomSpacing(5, after: contributorNameLabel)
        contributorNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        stackView.addArrangedSubview(createdAtLabel)
        stackView.setCustomSpacing(10, after: createdAtLabel)
        createdAtLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.setCustomSpacing(10, after: thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.height.equalTo(DeviceInformation.screenWidth / 2 - 40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        if let model = self.viewModel?.screenResult, !model.slideshow.isEmpty {
            stackView.addArrangedSubview(slideshowCollectionView)
            slideshowCollectionView.snp.makeConstraints {
                $0.height.equalTo(DeviceInformation.screenWidth / 3 - 50)
            }
            stackView.setCustomSpacing(10, after: slideshowCollectionView)
        }
        stackView.addArrangedSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        updateData()
    }
    
    private func updateData() {
        guard let model = self.viewModel?.screenResult else {
            return
        }
        titleLabel.text = model.title.capitalized
        contributorNameLabel.text = model.contributorName
        createdAtLabel.text = model.createdAt.dateFormat(from: .miliSeconds, to: .dayWithName)
        thumbnailImageView.loadImage(url: model.contentThumbnail)
        contentLabel.text = model.content
    }
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.viewModel?.screenResult else {
            return 0
        }
        return model.slideshow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = self.viewModel?.screenResult else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(for: indexPath, cell: SlideshowCollectionViewCell.self)
        cell.configure(url: model.slideshow[indexPath.row], completion: {
            cell.setNeedsLayout()
        })
        return cell
    }
}
