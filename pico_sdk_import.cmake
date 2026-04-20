# pico_sdk_import.cmake — мостик к установленному Pico SDK
if (DEFINED ENV{PICO_SDK_PATH})
    set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
endif()

if (PICO_SDK_PATH AND EXISTS "${PICO_SDK_PATH}")
    include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
else()
    message(FATAL_ERROR
        "❌ Pico SDK не найден!\n"
        "1. Проверь: echo $PICO_SDK_PATH\n"
        "2. Если пусто: echo 'export PICO_SDK_PATH=~/pico-sdk' >> ~/.zshrc && source ~/.zshrc"
    )
endif()