#!/usr/bin/fish

echo $argv[1]
set bar_len (echo (grep -o -m 1 '^\[[-#]\+\]' $argv[1] | wc -c) - 3 | bc)
set tot_problem (grep '\* \[[ x]\] problem' $argv[1] | wc -l)
set solved_problem (grep '\* \[[x]\] problem' $argv[1] | wc -l)
set solved_rate (echo "$solved_problem * 100 / $tot_problem" | bc | sed 's/$/%/')
set bar_solved (echo "$solved_problem * $bar_len / $tot_problem" | bc)
set bar_unslved (math $bar_len - $bar_solved)

echo "tot problems         = $tot_problem"
echo "solved problems      = $solved_problem"
echo "solved rate          = $solved_rate"
echo "bar length           = $bar_len"
echo "bar length of solved = $bar_solved"

set bar '['(head -c $bar_solved < /dev/zero | tr '\0' '#')
set tbar (head -c $bar_unslved < /dev/zero | tr '\0' '-')
set bar (echo "$bar$tbar")'] '$solved_rate
echo $bar

sed -i "s/^\[.*\] [0-9]\+%/$bar/" $argv[1]

