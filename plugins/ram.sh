
#!/usr/bin/env bash

# Получаем использованную память в гигабайтах (например "8.4G")
used_gb=$(top -l 1 -s 0 | grep PhysMem | awk '{print $2}' | tr -d 'used,')

# Удаляем "G" и преобразуем в число
used_gb_value=${used_gb%G}

# Рассчитываем проценты (16GB = 100%)
used_percent=$(echo "scale=0; $used_gb_value * 100 / 16" | bc)

# Обновляем sketchybar
sketchybar -m --set "$NAME" label="${used_percent}%"
