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
    
    let todoTable = UITableView()
    
    var todoItem: [TodoTask] = []
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        view.backgroundColor = .white
        
        calendar.delegate = self
        calendar.dataSource = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        view.addSubview(calendar)
        setCalendarLayout()
        
        
    }
    
    func setCalendarLayout(){
        calendar.snp.makeConstraints{
            $0.height.equalToSuperview().dividedBy(3)
            $0.width.equalToSuperview().dividedBy(1.2)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
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
