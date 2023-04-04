//
//  HabitDetailViewController.swift
//  Habitual
//
//  Created by Claudia Munoz on 4/3/23.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
        var habit: Habit!
        var habitIndex: Int!
        private var persistence = PersistenceLayer()

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelCurrentStreak: UILabel!
    @IBOutlet weak var labelBestStreak: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var labelTotalCompletion: UILabel!
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        }
    
    
    @IBAction func pressActionButton(_ sender: Any) {
        habit = persistence.markHabitAsCompleted(habitIndex)
           updateUI()
    }
    
    private func updateUI() {
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        labelCurrentStreak.text = "\(habit.currentStreak) days is the current streak"
        labelTotalCompletion.text = String(habit.numberOfCompletions)
        labelBestStreak.text = String(habit.bestStreak)
        labelStartingDate.text = habit.dateCreated.stringValue

        if habit.completedToday {
            buttonAction.setTitle("Completed for Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as Completed", for: .normal)
        }
    }
   

        // Do any additional setup after loading the view.
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
