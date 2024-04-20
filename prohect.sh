#!/bin/bash

copyrovanie() {
    local copir_dir="$1"
    local perenos_dir="$2"
    local dir_name=$(basename "$copir_dir") #добавляем к файлу название директории чтобы при одинаковых именах не было ошибки

    for file in "$copir_dir"/*; do
        if [ -f "$file" ]; then
            cp "$file" "$perenos_dir/$dir_name-$(basename "$file")"
            echo "Скопирован файл: $file"
        elif [ -d "$file" ]; then
            copyrovanie "$file" "$perenos_dir" # с помощью рекурсии снова отправляем на вход директорию в случае если наш нынешний файл - директория
        fi
    done
}

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <исходная директория> <целевая директория>"
    exit 1
fi

cop_directory="$1"
per_directory="$2"

if [ ! -d "$cop_directory" ]; then
    echo "Директория '$cop_directory' не существует"
    exit 1
fi


if [ ! -d "$per_directory" ]; then
    echo "Директория '$per_directory' не существует"
    exit 1
fi

copyrovanie "$cop_directory" "$per_directory"