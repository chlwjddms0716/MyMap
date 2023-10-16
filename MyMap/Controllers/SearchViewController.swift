//
//  SearchViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    private var historyArray: [SearchHistory] = []
    
    private let databaseManager = DatabaseManager.shared
    private let authManager = AuthManager.shared
    
    var keyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        setupTextField()
        setupAddTarget()
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchView.searchTextField.becomeFirstResponder()
        fetchHistory()
        
        if keyword.count > 0 {
            searchView.searchTextField.text = keyword
            keywordButtonTapped()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.keyword = ""
    }
    
    func fetchHistory(){
        guard let user = UserDefaultsManager.shared.getUserInfo() else { return }
        
        self.databaseManager.getSearchHistory(user: user) { historyData in
            guard let history = historyData else { return }
            self.historyArray = history
            DispatchQueue.main.async{
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    func setupCollectionView(){
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(KeywordCell.self
                                           , forCellWithReuseIdentifier: Cell.MainKeywordCellIdentifier)
    }
    
    func setupTextField(){
        searchView.searchTextField.addTarget(self, action: #selector(textFieldEditChanged), for: .editingChanged)
        searchView.searchTextField.delegate = self
    }
    
    func setupTableView(){
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        
        searchView.tableView.register(HistoryCell.self, forCellReuseIdentifier: Cell.HistoryCellIdentifier)
    }
    
    func setupAddTarget(){
        searchView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        searchView.removeButton.addTarget(self, action: #selector(historyRemoveTapped), for: .touchUpInside)
    }
    
    @objc func historyRemoveTapped(){
        if historyArray.count > 0 {
            guard let user = UserDefaultsManager.shared.getUserInfo() else { return }
            databaseManager.removeAllKeyword(user: user)
            
            historyArray = []
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    @objc func backButtonTapped(){
        dismiss(animated: false)
    }
    
    @objc func textFieldEditChanged(){
        
    }
    
    func keywordButtonTapped() -> Bool {
        
        guard let textKeyword =  searchView.searchTextField.text else { return false }
        if textKeyword.trimmingCharacters(in: .whitespaces).count <= 0 {
            return false
        }
        
        searchView.searchTextField.resignFirstResponder()
    
        let vc = SearchResultViewController()
        vc.keyword = textKeyword
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
      
        if let user = UserDefaultsManager.shared.getUserInfo(){
            databaseManager.insertSearchKeyword(user: user, keyword: textKeyword)
        }
        
        return true
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KeywordManager.SearchKeywordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: Cell.MainKeywordCellIdentifier, for: indexPath) as? KeywordCell else { return  UICollectionViewCell() }
        
        cell.keyword = KeywordManager.SearchKeywordArray[indexPath.row]
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchView.searchTextField.text = KeywordManager.SearchKeywordArray[indexPath.row].keyword
        keywordButtonTapped()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchView.tableView.dequeueReusableCell(withIdentifier: Cell.HistoryCellIdentifier, for: indexPath) as? HistoryCell else { return UITableViewCell() }
       
        cell.history = historyArray[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchView.searchTextField.text = historyArray[indexPath.row].term
        keywordButtonTapped()
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    // 엔터 눌렀을 때
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        
        return keywordButtonTapped()
    }
}
