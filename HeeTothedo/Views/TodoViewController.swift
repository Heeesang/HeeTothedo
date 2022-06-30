import UIKit
import FSCalendar
import SnapKit
import Then

class TodoViewController: UIViewController{
    
    let calendar = FSCalendar().then {
        $0.headerHeight = 50
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .black
        $0.appearance.headerTitleFont = UIFont.systemFont(ofSize: 21)
        $0.scrollDirection = .horizontal
    }
    
    let dateFormatter = DateFormatter()
    
    let todoTable:UITableView = UITableView()
    
    var todoItem: [TodoTask] = [TodoTask(title: "잠 자기")]
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        view.backgroundColor = .white
        
        calendar.delegate = self
        calendar.dataSource = self
        todoTable.delegate = self
        todoTable.dataSource = self
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        view.addSubview(calendar)
        view.addSubview(todoTable)
        setCalendarLayout()
        setTableViewLayout()
        
    }
    
    func setCalendarLayout(){
        calendar.snp.makeConstraints{
            $0.height.equalToSuperview().dividedBy(3)
            $0.width.equalToSuperview().dividedBy(1.2)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setTableViewLayout(){
        todoTable.snp.makeConstraints{
            $0.top.equalTo(calendar.snp.bottom)
            $0.height.width.equalToSuperview()
            
            
        }
    }
}

extension TodoViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
}

extension TodoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = todoTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoItem[indexPath.row].title
        return cell
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoItem.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = todoTable.dequeueReusableCell(withIdentifier: TodoTableCell.cellId, for: indexPath) as! TodoTableCell
//
//        cell.todoTitle.text = todoItem[indexPath.row].title
//
//        return cell
//    }


}
