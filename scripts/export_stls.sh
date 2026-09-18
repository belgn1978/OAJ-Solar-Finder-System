#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$project_dir/openscad/solar_finder.scad"
output_dir="$project_dir/stl"

mkdir -p "$output_dir"

for component in body nacatin_adapter pinhole_plate target_plate; do
  openscad \
    -o "$output_dir/OAJ_SFS_P1_${component}.stl" \
    -D "part=\"${component}\"" \
    "$source_file"
done

echo "Exported P1 STL set to $output_dir"
