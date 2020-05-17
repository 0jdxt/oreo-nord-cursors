#!/usr/bin/env bash
# Generate oreo cursors, just changing colours

declare -A colors=(
    [night_1]="#2E3440"
    [night_2]="#3B4252"
    [night_3]="#434C5E"
    [night_4]="#4C566A"
    [snow_1]="#D8DEE9"
    [snow_2]="#E5E9F0"
    [snow_3]="#ECEFF4"
    [frost_1]="#8FBCBB"
    [frost_2]="#88C0D0"
    [frost_3]="#81A1C1"
    [frost_4]="#5E81AC"
    [red]="#BF616A"
    [orange]="#D08770"
    [yellow]="#EBCB8B"
    [green]="#A3BE8C"
    [purple]="#B48EAD"
)

BASE_DIR="oreo_base"
base_mtime=$(stat -c '%Y' "$BASE_DIR")
for color in "${!colors[@]}"; do
    COLOR_DIR="src/oreo_nord_${color}_cursors"
    color_mtime=$(stat -c '%Y' "$COLOR_DIR" 2>/dev/null || echo 0)

    # if oreo_base hasnt changed, only generate if folder non existant
    if ((color_mtime > base_mtime)) && [ -d "$COLOR_DIR" ]; then
        continue
    fi

    rm -rf "$COLOR_DIR"
    mkdir "$COLOR_DIR"

    echo "Generating $color..."
    for orig_path in "$BASE_DIR"/*; do
        file=$(basename "$orig_path")
        new_path="$COLOR_DIR/$file"

        # dark highlight for snow, else light
        case $color in
            snow*) re_white=${colors[night_4]};;
            *) re_white=${colors[snow_3]};;
        esac

        sed "s/#4e81ed/${colors[color]}/g; s/#000000/$re_white/g; s/#ffffff/${colors[night_1]}/g" <"$orig_path" >"$new_path"
    done

    name="${color/_/ }"

    theme_file="$(cat <<-EOF
	[Icon Theme]
	Name=Oreo Nord ${name[*]^} Cursors
	Comment=design by varlesh
	EOF
    )"

    echo "$theme_file" > "$COLOR_DIR/index.theme"
done

echo "Ready to build!"

