import UIKit
import FSCalendar
import SnapKit
import Then

class TodoViewController: UIViewController{
    
    private let calendar = FSCalendar().then{
        $0.headerHeight = 50
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .black
        $0.appearance.headerTitleFont = UIFont.systemFont(ofSize: 25)
        $0.appearance.weekdayFont = UIFont.systemFont(ofSize: 18)
        $0.scrollDirection = .horizontal
    }
    
    private let todoTextField = UITextField().then{
        $0.placeholder = "todo 입력.."
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .white
        $0.setLeftPaddingPoints(10)
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
    }
    
    private let plusTodoButton = UIButton().then{
        $0.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
    }
    
    private let dateFormatter = DateFormatter()
    
    private let todoTable:UITableView = UITableView()
    
    private var todoItem: [todoTask] = [todoTask(title: "잠 자기"),todoTask(title: "공부하기")]
    
    
    
    
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
        view.addSubview(todoTextField)
        view.addSubview(plusTodoButton)
        view.addSubview(todoTable)
        setLayout()
        
    }
    
    func setLayout(){
        calendar.snp.makeConstraints{
            $0.height.equalToSuperview().dividedBy(3)
            $0.width.equalToSuperview().dividedBy(1.2)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        todoTable.snp.makeConstraints{
            $0.top.equalTo(todoTextField.snp.bottom).offset(10)
            $0.height.width.equalToSuperview()
        }
        
        todoTextField.snp.makeConstraints{
            $0.top.equalTo(calendar.snp.bottom).offset(10)
            $0.height.equalToSuperview().dividedBy(17)
            $0.width.equalToSuperview().dividedBy(1.4)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        plusTodoButton.snp.makeConstraints{
            $0.left.equalTo(todoTextField.snp.right).offset(20)
            $0.top.equalTo(calendar.snp.bottom).offset(10)
            $0.height.equalTo(todoTextField.snp.height)
            $0.width.equalTo(50)
        }
    }
    
    @objc func addTodoItem(_ sender: UIButton) {
        todoItem.append(todoTask(title: self.todoTextField.text!))
        self.todoTextField.text = ""
        
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
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
}


