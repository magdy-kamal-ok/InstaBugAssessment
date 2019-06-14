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
        setAccessiblityIdentifiers()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setAccessiblityIdentifiers()
    {
        self.moviesTableView.accessibilityIdentifier = Constants.TABLEVIEW_IDENTIFIER

    }
    // MARK: right navbar button
    private func setupAddButtonToNavigation() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddNewMovie))
        addBarButton.accessibilityIdentifier = Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER
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

        self.refreshControl?.accessibilityIdentifier = Constants.PULL_REFRESH_INDICATOR_IDENTIFIER
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
        self.paginationIndicator?.accessibilityIdentifier = Constants.Load_More_INDICATOR_IDENTIFIER
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

    func getCellsCount(with section:Int)->Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set number of cells count")
    }

    func getSectionsCount()->Int
    {
        preconditionFailure("You have to Override getSectionsCount Function first to be able to set number of sections count")
    }
    
    func getSectionTitle(with section:Int)->String
    {
        preconditionFailure("You have to Override getSectionsTitle Function first to be able to set section title")
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
    // MARK: Title for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return self.getSectionTitle(with:section)
    }
    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }
    
    // MARK: Number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount(with:section)
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
        }
    }
}
