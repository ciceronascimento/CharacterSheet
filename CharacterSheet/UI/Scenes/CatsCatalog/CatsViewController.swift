//
//  CatsViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import UIKit

class CatsViewController: UIViewController {

    var racas: [CatAPIModel] = []

    let scrollView = UIScrollView()
    let stackView = UIStackView()

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        testAPI()
        view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        addContentToStackView()
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

    func testAPI() {
        Task {
            racas = try await APIManager().getData(apiConfig: CatAPIRoute(aPIRoutes: .breeds))
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
            for i in racas {
                print(i.name)
            }
        }
    }
}

// MARK: - StackView
extension CatsViewController {
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}


extension CatsViewController {
    func addContentToStackView() {
        let mostPopularCats = createCollectionView()
        mostPopularCats.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.addArrangedSubview(mostPopularCats)

        let favouriteCats = createCollectionView()
        favouriteCats.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.addArrangedSubview(favouriteCats)

        let allCats = createTableView()
        allCats.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stackView.addArrangedSubview(allCats)
    }
}

// MARK: - CollectionView
extension CatsViewController {
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "pets")
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }
}

extension CatsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pets", for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
}

// MARK: - TableView

extension CatsViewController {
    func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "allPets")
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
        return tableView
    }
}

extension CatsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Pets"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return racas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allPets", for: indexPath)
        let raca = racas[indexPath.row]
        cell.textLabel?.text = raca.name
        cell.backgroundColor = .clear
        return cell
    }
}
