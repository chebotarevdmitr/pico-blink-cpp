# 🍓 Raspberry Pi Pico Blink (C++)

Добро пожаловать в мой первый проект на Raspberry Pi Pico! 🎉  
Здесь мы учимся мигать встроенным светодиодом, но делаем это с серьёзным лицом, подробными комментариями и лёгким юмором.

> 💡 **Статус проекта:** ✅ Код написан, среда настроена, прошивка `blink.uf2` успешно собрана.  
> 📦 Плата пока в пути, но проект полностью готов к прошивке и расширению.

---

## 📖 Описание

Этот проект написан на **C++** с использованием **Raspberry Pi Pico SDK** и системы сборки **CMake**.  
Основная цель — заставить встроенный светодиод на плате мигать каждые полсекунды. Казалось бы, просто, но именно так начинается путь к уверенной работе с микроконтроллерами.

Проект создан как **учебный шаг**: с подробными комментариями в коде, понятными инструкциями по настройке и чек-листами для будущих экспериментов.

---

## 📋 Предварительные требования

| Компонент | Зачем нужен | Как проверить |
|-----------|-------------|---------------|

| **Ubuntu Linux** (или другой Linux) | Рабочая ОС для сборки | `lsb_release -a` |
| **Zsh** или **Bash** | Оболочка для терминала | `echo $SHELL` |
| **Git** | Управление версиями | `git --version` |
| **CMake ≥ 3.13** | Система сборки | `cmake --version` |
| **ARM GCC Toolchain** | Кросс-компилятор для RP2040 | `arm-none-eabi-gcc --version` |
| **Pico SDK** | Библиотеки и заголовки Pico | `echo $PICO_SDK_PATH` |
| **VS Code** | Редактор кода + IntelliSense | `code --version` |

🛠️ Если чего-то нет, установи одной командой:
```bash
> sudo apt update && sudo apt install -y git cmake gcc-arm-none-eabi build-essential
> ```

---

## ⚙️ Пошаговая настройка и сборка

### 1️⃣ Установи Pico SDK (если ещё не установлен)

```bash
cd ~
git clone -b master https://github.com/raspberrypi/pico-sdk.git
cd pico-sdk
git submodule update --init


2️⃣ Настрой переменную окружения
Добавь путь к SDK в конфигурацию своей оболочки:
Для Zsh:
echo 'export PICO_SDK_PATH=~/pico-sdk' >> ~/.zshrc
source ~/.zshrc

Для Bash:
echo 'export PICO_SDK_PATH=~/pico-sdk' >> ~/.bashrc
source ~/.bashrc

Проверь: echo $PICO_SDK_PATH → должно вывести /home/твой_пользователь/pico-sdk 

3️⃣ Клонируй и собери проект

git clone https://github.com/chebotarevdmitr/pico-blink-cpp.git
cd pico-blink-cpp
mkdir -p build && cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)
cd ..

✅ После сборки в папке build/ появится файл blink.uf2 (~18 КБ).
4️⃣ Настрой VS Code (убираем красные линии под #include)
Если IntelliSense ругается на pico/stdlib.h, создай .vscode/c_cpp_properties.json:

{
    "configurations": [{
        "name": "Linux-Pico",
        "includePath": [
            "${workspaceFolder}/**",
            "${env:PICO_SDK_PATH}/src/**",
            "${env:PICO_SDK_PATH}/src/boards/include/**",
            "${env:PICO_SDK_PATH}/src/rp2_common/**",
            "${env:PICO_SDK_PATH}/lib/**"
        ],
        "compilerPath": "/usr/bin/arm-none-eabi-gcc",
        "cStandard": "c11",
        "cppStandard": "c++17",
        "intelliSenseMode": "linux-gcc-arm"
    }],
    "version": 4
}

Затем: Ctrl+Shift+P → C/C++: Reset IntelliSense Database → подожди 5 сек. Готово! 🎉

📂 Структура проекта

├── blink.cpp                # Основной код на C++ (подробно прокомментирован)
├── CMakeLists.txt           # Настройки сборки для CMake
├── pico_sdk_import.cmake    # Мостик между проектом и Pico SDK
├── .vscode/c_cpp_properties.json # Настройки IntelliSense для VS Code
├── build/                   # Папка сборки (игнорируется в Git)
├── .gitignore               # Исключаем временные файлы
├── README.md                # Эта документация
└── LICENSE                  # Лицензия MIT

🔌 Как прошить на реальную плату (когда появится)

Отключи Pico от USB.
Зажми кнопку BOOTSEL на плате.
Подключи Pico к USB (кнопку не отпускай).
На компьютере появится виртуальный диск RPI-RP2.
Скопируй файл build/blink.uf2 на этот диск.
Диск автоматически отключится, Pico перезагрузится.
Отпусти кнопку и наблюдай: встроенный светодиод мигает раз в секунду! ✨

⚠️ Никогда не выдёргивай USB во время копирования .uf2. Если процесс прервётся, Boot ROM восстановит возможность прошивки при следующем нажатии BOOTSEL.

🛠️ Решение типичных проблем

Проблема
Причина
Решение
CMake Error: pico_sdk_import.cmake not found
Файл отсутствует в корне проекта
Создай его по инструкции выше или проверь, что ты в правильной папке

Unknown command "pico_sdk_init"
SDK не найден или путь неверен
Проверь echo $PICO_SDK_PATH и запусти source ~/.zshrc
arm-none-eabi-gcc: command not found
Не установлен ARM-компилятор
sudo apt install gcc-arm-none-eabi

Красные линии в VS Code
IntelliSense не видит пути SDK
Создай .vscode/c_cpp_properties.json и сбрось базу данных

make падает с undefined reference
Не подключена библиотека в CMake
Убедись, что в CMakeLists.txt есть target_link_libraries(blink pico_stdlib)

📜 Лицензия
Проект распространяется под лицензией MIT.
Это значит: бери, используй, модифицируй, но не забывай упоминать автора.
И да, если твой робот-пылесос начнёт мигать светодиодом каждые полсекунды — я не виноват 😅.

Даже мигающий светодиод может быть поводом для радости 💡🐧
🛠️✨
