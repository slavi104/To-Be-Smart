module Constants
  PASSWORD_MIN_LENGHT = 6
  LINKS_PER_ROW = 2
  EMAIL_MIN_LENGHT = 9
  EMAIL_MAX_LENGHT = 50
  WRONG_PASSWORD = "Грешна парола!"
  WRONG_EMAIL = "Грешен Email!"
  SHORT_PASSWORD = "Паролата е прекалено къса! Минимумът е 6 символа!"
  USERNAME_TAKEN ="Това име вече е заето!"
  EMAIL_TOO_SHORT = "Минимума на символи за Email е 50! "
  EMAIL_TOO_LONG = "Надвишили сте максимума символи за Email който е #{EMAIL_MAX_LENGHT} символа!"
  NOTVALID_EMAIL = "Въведете валиден Email!"
  NOTEQUAL_PASSWORDS = "Паролите не съвпадат!"
  HOST = '127.0.0.1'
  HOST_USER = 'root'
  HOST_PASSWORD = 'pass'
  NO_OLD_PASSWORD = "Няма въведена парола!"
  WRONG_PASSWORD_REPEAT = "Грешно повторена парола!"
  GRADED_TEST = "Решен тест"
  POINTS = "Изкарани точки"
  CATEGORIES = {
    'history' => "История" ,
    'geography' => "География",
    'iq' => "IQ",
    'music' => "Музика",
    'movies' => "Филми",
    'general' => "Общи"
     }
end