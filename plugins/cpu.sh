
#!/usr/bin/env bash

# Получаем количество логических ядер CPU (кросс-платформенный способ)
CORE_COUNT=$(sysctl -n hw.logicalcpu 2>/dev/null || nproc 2>/dev/null || echo 1)

# Получаем загрузку CPU для всех процессов (без заголовка)
CPU_INFO=$(ps -eo pcpu= 2>/dev/null)

# Суммируем загрузку CPU и нормализуем на количество ядер
CPU_USAGE=$(echo "$CPU_INFO" | awk -v cores="$CORE_COUNT" '{ sum += $1 } END { printf "%.0f", sum / cores }')

# Обновляем sketchybar (с проверкой на ошибки)
if [ -n "$CPU_USAGE" ]; then
    sketchybar -m --set cpu_percent label="${CPU_USAGE}%"
else
    sketchybar -m --set cpu_percent label="N/A"
fi
