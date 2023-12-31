//
//  DogsViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import UIKit
import Combine

class PetsViewController<T: AnimalData>: UIViewController {

    let apiManager: APIManager<T>

    private(set) var petsViewModel = PetsViewModel()
    private var cancellables = Set<AnyCancellable>()

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var favCollectionView: HighlightsCollectionView!
    var allPetsTableView: AllPetsTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ApiManager: \(apiManager)")
        view.backgroundColor = .white
        petsViewModel.fetchPets(apiManager: apiManager, completion: {})

        favCollectionView = HighlightsCollectionView()
        favCollectionView.petsViewModel = petsViewModel

        allPetsTableView = AllPetsTableViewController()
        allPetsTableView.petsViewModel = petsViewModel

        setupScrollView()
        setupStackView()
        addContentToStackView()
        setupViewModel()
    }

    init(apiManager: APIManager<T>) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    func setupViewModel() {
        petsViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.allPetsTableView.tableView.reloadData()
            }
            .store(in: &cancellables)
        petsViewModel.$highlightsImg
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.allPetsTableView.tableView.reloadData()
                self?.favCollectionView.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
