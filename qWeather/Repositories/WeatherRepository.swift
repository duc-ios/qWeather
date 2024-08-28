//
//  TaskRepository.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

//protocol TaskRepository {
//    func fetch(status: CountryModel.Status?) throws -> [CountryModel]
//    func delete(task: CountryModel) throws
//    func createTask(with formFields: CreateTaskFormField) throws -> CountryModel
//    func update(task: CountryModel, formFields: CreateTaskFormField) throws -> CountryModel
//    func updateOrder(tasks: [CountryModel]) throws
//    func mark(task: CountryModel, status: CountryModel.Status) throws
//}
//
//class LocalTaskRepository: TaskRepository {
//    private let database: MockDB
//
//    init(database: MockDB? = nil) {
//        self.database = database ?? MockDB()
//    }
//
//    func fetch(status: CountryModel.Status? = nil) throws -> [CountryModel] {
//        if let status = status {
//            return try database.read(
//                predicate: #Predicate { $0.rawStatus == status.rawValue },
//                sortBy: SortDescriptor(\.order), SortDescriptor(\.timestamp)
//            )
//        } else {
//            return try database.read(
//                sortBy: SortDescriptor(\.order), SortDescriptor(\.timestamp)
//            )
//        }
//    }
//
//    func delete(task: CountryModel) throws {
//        try database.delete(task)
//    }
//
//    func createTask(with formFields: CreateTaskFormField) throws -> CountryModel {
//        var category = TaskCategory(rawValue: formFields.category) ?? .personal
//        if formFields.category == "Custom" {
//            category = .custom(formFields.customCategory)
//        }
//        let task = CountryModel(
//            timestamp: formFields.date,
//            name: formFields.name.isEmpty ? "Task" : formFields.name,
//            desc: formFields.desc,
//            category: category,
//            priority: formFields.priority,
//            status: .pending,
//            reminder: formFields.reminder,
//            order: 0
//        )
//        try database.create(task)
//        return task
//    }
//
//    func update(task: CountryModel, formFields: CreateTaskFormField) throws -> CountryModel {
//        var category = TaskCategory(rawValue: formFields.category) ?? .personal
//        if formFields.category == "Custom" {
//            category = .custom(formFields.customCategory)
//        }
//        task.timestamp = formFields.date
//        task.name = formFields.name.isEmpty ? "Task" : formFields.name
//        task.desc = formFields.desc
//        task.rawCategory = category.rawValue
//        task.rawPriority = formFields.priority.rawValue
//        task.rawReminder = formFields.reminder.rawValue
//        try database.create(task)
//        return task
//    }
//
//    func updateOrder(tasks: [CountryModel]) throws {
//        try tasks.enumerated().forEach {
//            $0.element.order = $0.offset
//            try database.create($0.element)
//        }
//    }
//
//    func mark(task: CountryModel, status: CountryModel.Status) throws {
//        task.rawStatus = status.rawValue
//        try database.create(task)
//    }
//}
