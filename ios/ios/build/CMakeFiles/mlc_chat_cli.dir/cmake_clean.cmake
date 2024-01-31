file(REMOVE_RECURSE
  "mlc_chat_cli.app/mlc_chat_cli"
  "mlc_chat_cli.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/mlc_chat_cli.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
