//
//  LocalizedStrings.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/6/21.
//

import Foundation
import UIKitPlus

class LocalizedStrings {
    static let logout = String(.en("Logout"), .ru("Выход"))
    static let networkError = String(.en("Network error"), .ru("Ошибка сети"))
    static let checkAndRetry = String(.en("Check your interner connection and try again."),
                                      .ru("Проверьте свое интернет-соединение и попробуйте снова."))
    static let checkAndRelogin = String(.en("Check your internet connection and relogin into your account."),
                                        .ru("Проверьте свое интернет-соединение и перезайдите в аккаунт."))
    static let ok = String(.en("Ok"), .ru("Ок"))
    static let areYouSureLogOut = String(.en("Are you sure you want to log out?"),
                                         .ru("Вы уверены, что хотите выйти?"))
    static let doLogOut = String(.en("Log out"), .ru("Выйти"))
    static let cancel = String(.en("Cancel"), .ru("Отмена"))
    static let successSave = String(.en("Successfully saved!"), .ru("Изображение успешно сохранено!"))
    static let enterViaVK = String(.en("Enter via VK"), .ru("Вход через VK"))
}
