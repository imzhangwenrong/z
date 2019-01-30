#!/usr/bin/env awk -f
BEGIN {
stack=""
}

{
  if ($0 ~ /^Thread/) {
    if (stack != "") {
      stackmap[stack]++;
      stack="";
    }
  } else {
    sub(/\(.*\) at /, "(_) at ")
    sub(/\(.*\) from /, "(_) from ")
    stack = stack "" $0 "\n"
  }
}

END {
  if (stack != "") {
    stackmap[stack]++;
    stack="";
  }

  PROCINFO["sorted_in"] = "@val_num_desc"
  for (key in stackmap) {
    printf("=== %d ===\n%s", stackmap[key], key);
  }
}
