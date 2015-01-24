module Constants
  COLORS = {
    0 => "tile-blue" ,
    1 => "tile-green",
    2 => "tile-red",
    3 => "tile-yellow",
    4 => "tile-orange",
    5 => "tile-pink",
    6 => "tile-purple",
    7 => "tile-lime",
    8 => "tile-magenta",
    9 => "tile-teal"
     }
  PASSWORD_MIN_LENGHT = 6
  LINKS_PER_ROW = 2
  EMAIL_MIN_LENGHT = 9
  EMAIL_MAX_LENGHT = 50
  WRONG_PASSWORD = "Грешена парола !"
  WRONG_EMAIL = "Грешен Email !"
  SHORT_PASSWORD = "Паролата е прекалено къса ! Минимума е #{PASSWORD_MIN_LENGHT} символа"
  USERNAME_TAKEN ="Това име вече е заето !"
  EMAIL_TOO_SHORT = "Минимума на символи за Email е #{EMAIL_MIN_LENGHT} ! "
  EMAIL_TOO_LONG = "Надвишили сте максимума символи за Email който е #{EMAIL_MAX_LENGHT} символа !"
  NOTVALID_EMAIL = "Въведете валиден Email !"
  DISPLAY_NEWS = 3
  LINKS_MIN_LENGHT = 6
  LINK_MIN_ERROR = "Минимума на символи за линк е #{LINKS_MIN_LENGHT} ! "
  LINK_NAME_MIN = 3
  LINK_NAME_MIN_ERROR = "Минимума на символи за име на линк е #{LINK_NAME_MIN} ! "
  HOST = '127.0.0.1'
  HOST_USER = 'root'
  HOST_PASSWORD = 'pass'
  HOST_DATABASE ='myhomepage_ruby'
  NO_OLD_PASSWORD = "Няма въведена парола !"
  WRONG_PASSWORD_REPEAT = "Грешно повторена парола !"
end