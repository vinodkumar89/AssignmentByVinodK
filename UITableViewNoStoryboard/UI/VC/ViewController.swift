//
//  ViewController.swift
//  UITableViewNoStoryboard


import UIKit
import Reachability
class ViewController: UIViewController {
  
  let fVM = FactViewModel()
    var tableView = UITableView()
    var refreshControl   = UIRefreshControl()
  let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()

             /* Checks for  internet connection */
       if  AppDelegate().appDelegate().isInternetAvailable() == false
               {
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
               self.showAlert()
               })
               return
               }
         /* Binding with view model */
        fVM.delegate = self
        fVM.updateFacts()
        
          /* Setting up UI */
         self.setupUI()
    }
 
  
  override func viewWillAppear(_ animated: Bool) {
    /* register network notification */
      NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
      do{
        try reachability.startNotifier()
      }catch{
        print("could not start reachability notifier")
      }
  }
  
  
  
    func  setupUI(){
           /* Setup reload button on navbar */
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(self.reCallAPI))
     
             /* Setup initial frame of tableview and tableview style */
              tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
              /* Setup tableview background color */
               tableView.backgroundColor = UIColor.white
              /* Register CustomCell with tableview */
               tableView.register(CustomCell.self, forCellReuseIdentifier: kCustomCell)
              /* Setup Refresh controller with tableview  */
              refreshControl.attributedTitle = NSAttributedString(string: kPulltorefresh)
               refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
               self.tableView.addSubview(refreshControl)
                   /* Setup tableview footer view */
               let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
               let displayWidth: CGFloat = self.view.frame.width
               let displayHeight: CGFloat = self.view.frame.height
                tableView.contentInset.top = 0
         tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let contentSize = self.tableView.contentSize
          let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                                 y: self.tableView.frame.origin.y + contentSize.height,
                                                 width: self.tableView.frame.size.width,
                                                 height: self.tableView.frame.height - self.tableView.contentSize.height))
              
               self.tableView.tableFooterView = footer
             view.addSubview(tableView)
           /* Setup constraints on tableview */
            tableView.translatesAutoresizingMaskIntoConstraints = false
             tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
             tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
    }
    
      // MARK: - Method for refresh Tableview
    @objc func refresh(_ sender: Any) {
        refreshControl.beginRefreshing()
        fVM.updateFacts()
    }
  
  // MARK: - Method for reload data
    @objc func reCallAPI(_ sender: Any) {
        refreshControl.beginRefreshing()
        fVM.updateFacts()
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   // MARK: - Method for Network change
  @objc func reachabilityChanged(note: Notification) {

    let reachability = note.object as! Reachability

    switch reachability.connection {
    case .wifi:
        print("Reachable via WiFi")
    case .cellular:
        print("Reachable via Cellular")
    case .unavailable:
      print("Network not reachable")
      self.showAlert()
      case .none:
     print("Network not reachable")
       self.showAlert()
    }
  }
  
       
 // MARK: -  Method for Show Internet alert
    func showAlert(){
       fVM.updateFacts()
     self.alert(message:kAlertMessage_InternetNotAvailable)
    }
}
  // MARK: - Table view Data source
extension ViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fVM.factData.count
        }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // configure coustom cell
            let cell = tableView.dequeueReusableCell(withIdentifier: kCustomCell, for: indexPath) as! CustomCell
            let currentLastItem = fVM.factData[indexPath.row]
           cell.rData = currentLastItem
            return cell
        }
}


// MARK: - Table view Delegates
extension ViewController: UITableViewDelegate {
 
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return UITableViewAutomaticDimension
        }
  
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
}

// MARK: - FactViewModelProtocol Implementation
extension ViewController: FactViewModelProtocol {
     func didUpdateList() {
       /* End animating refresh controller */
        refreshControl.endRefreshing()
       /* Setup navigation title  with dynamic value */
        self.navigationItem.title = self.fVM.strTitle
        /* Setup tableview delegate and reload */
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}
