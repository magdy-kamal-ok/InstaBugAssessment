//
//  BaseMoviesListViewController.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class BaseMoviesListViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var cellNibName:String?
    var cellNib:UINib?
    
    public var paginationIndicator: UIActivityIndicatorView?
    private var refreshControl: UIRefreshControl?
    private var hasPagination: Bool = false
    
    // MARK: - Base Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableDataSource()
        setupCellNibName()
        setupCellNibRegistration()
        setupAddButtonToNavigation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: right navbar button
    private func setupAddButtonToNavigation() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddNewMovie))
        addBarButton.accessibilityIdentifier = "AddMoview"
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    //MARK:- Movie Details Action
    @objc func openAddNewMovie()   {
       handleOpenAddNewMoview()
    }
    
    func handleOpenAddNewMoview() {
        // override this when you need to handleOpenAddNewMoview
    }
    
    // MARK: Refresh cotrol
    func setupSwipeRefresh() -> Void {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(swipeRefreshTableView), for: .valueChanged)
        self.moviesTableView.addSubview(refreshControl!)
    }
    
    @objc func swipeRefreshTableView() {
        // override this when you need to refresh table data by swipe
    }
    
    func endRefreshTableView() -> Void {
        self.refreshControl?.endRefreshing()
    }
    
    //MARK: Pagination
    func setupPagination() -> Void {
        hasPagination = true
    }
    
    func handlePaginationRequest() {
        // override this when you need to handlePaginationRequest
    }
    
    func showLoadingMoreHeader() -> Void {
        paginationIndicator = UIActivityIndicatorView.init()
        paginationIndicator?.color = UIColor.gray
        paginationIndicator?.sizeToFit()
        paginationIndicator?.startAnimating()
        self.moviesTableView.tableFooterView =  paginationIndicator
    }
    
    func removeLoadingMoreHeader(){
        if paginationIndicator != nil{
            if paginationIndicator!.isDescendant(of: self.view) {
                paginationIndicator?.removeFromSuperview()
                paginationIndicator = nil
            }
        }
    }
    
    
    // MARK: - Table view
    
    func setupTableDataSource() -> Void {
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }
    
    
    // MARK: Table view nib name
    
    public func setupCellNibName() -> Void {
        // This methode will overridw at sub classes
    }
    
    
    // MARK: Table view nib registeration
    
    func setupCellNibRegistration() -> Void {
        assert((self.cellNibName != nil) && !(self.cellNibName?.isEmpty)!, "Cell nib name, Override setupCellNibName Func")
        self.moviesTableView.register(getCellNIB(), forCellReuseIdentifier: self.cellNibName!)
       
    }
    
    public func getCellNIB() ->UINib{
        if(self.cellNib == nil){
            assert((self.cellNibName != nil) && !(self.cellNibName?.isEmpty)!, "Cell nib name not set in controller")
            self.cellNib = UINib.init(nibName: self.cellNibName!, bundle: nil)
        }
        return self.cellNib!
    }
    
    
    func getCellHeight() -> CGFloat {
        preconditionFailure("You have to Override getCellHeight Function first to be able to set cell height")
    }

    func getCellsCount()->Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set nmber of cells count")
    }

    
    
    // MARK: - Loading Progress
    // MARK: Show
    
    public func showProgressLoaderIndicator(){
        DispatchQueue.main.async {
            self.loadingIndicator?.isHidden = false
            self.loadingIndicator?.startAnimating()
        }
      
    }
    
    
    // MARK: Hide
    
    public func hideProgressLoaderIndicator(){
        DispatchQueue.main.async {
            self.loadingIndicator?.isHidden = true
            self.loadingIndicator?.stopAnimating()
        }
      
    }
    
    
    func checkRefreshControlState() -> Void {
        DispatchQueue.main.async {
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
}


// MARK: - UITableViewDataSource

extension BaseMoviesListViewController : UITableViewDataSource{
    
    
    // MARK: Height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight()
    }
    
    
    // MARK: Number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount()
    }
    
    
    // MARK: Cell for row
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?  = tableView.dequeueReusableCell(withIdentifier: self.cellNibName!, for: indexPath)
        if(cell == nil){
            cell = self.cellNib?.instantiate(withOwner: self, options: nil)[0] as? UITableViewCell
        }
        return getCustomCell(tableView, customCell:cell!, cellForRowAt: indexPath)
    }
    
    @objc func getCustomCell(_ tableView: UITableView, customCell cusotmCell:UITableViewCell , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cusotmCell
    }
}

extension BaseMoviesListViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == moviesTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if (self.hasPagination) {
                    self.handlePaginationRequest()
                }
            }
            else
            {
                endRefreshTableView()
            }
        }
    }
}
