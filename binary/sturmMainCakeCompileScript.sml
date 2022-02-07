open preambleDandelion compilationLib sturmMainCakeTheory;

val _ = new_theory "sturmMainCakeCompile"

val checker_compiled = save_thm("checker_compiled",
  compile_x64 "sturmChecker" main_prog_def);

val _ = export_theory();
