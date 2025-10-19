function get_max()
  sc.lsetform(3, 1, "@max(B1:B69)")
  max_val = sc.lgetnum(3, 1)
  print("Max: " .. max_val)
end

function list_functions()
  print("Available functions in my_macros:")
  print("  - get_max()")
  print("  - list_functions()")
end

function help()
  list_functions()
end
