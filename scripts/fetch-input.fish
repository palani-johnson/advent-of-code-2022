#! /opt/homebrew/bin/fish

begin
  set output_file .local/inputs/day$argv[1].txt
  if test -e $output_file ;; else
    set headers "Cookie: session=$(cat .secrets/advent-session | string trim)"
    curl https://adventofcode.com/2022/day/$argv[1]/input -H $headers > $output_file
  end
end
