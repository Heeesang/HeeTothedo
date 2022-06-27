//
//  MainVc.swift
//  HeeTothedo
//
//  Created by 곽희상 on 2022/06/27.
//

import Foundation
import UIKit
import FSCalendar
import SnapKit
import Then

class todoViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
    let calendar = FSCalendar().then {
        $0.headerHeight = 50
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .black
        $0.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        view.backgroundColor = .white
        
        calendar.delegate = self
        calendar.dataSource = self
        
        view.addSubview(calendar)
        setCalendarLayout()
    }
    
    func setCalendarLayout(){
        calendar.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
