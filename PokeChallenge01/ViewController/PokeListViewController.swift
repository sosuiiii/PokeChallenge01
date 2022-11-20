//
//  PokeListViewController.swift
//  PokeChallenge01
//
//  Created by Tanaka Soushi on 2022/11/03.
//

import UIKit
// 差分
final class PokeListViewController: UIViewController {
    
    private let model = PokeListModel()

    @IBOutlet private var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(DummyTableViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.fetchPokemonData()
    }
}

// MARK: PokelListModelDelegate
extension PokeListViewController:  PokeListModelDelegate {
    func fetchPokemonDataSuccess() {
        tableview.reloadData()
    }
    func fetchPokemonDataFailure(error: PokeAPIError) {
        //TODO: アラートを出す
    }
}

// MARK: UITableViewDelegate
extension PokeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension PokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DummyTableViewCell.self, for: indexPath)
        cell.configure(pokemon: model.pokemons[indexPath.row])
        return cell
    }
}
