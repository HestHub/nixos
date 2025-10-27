function catbin -d "cat a binary in your path"
  if test (count $argv) -ne 1
    echo "usage: catbin something_in_your_path" >&2
    return 1
  end

  if command -v bat >/dev/null
    set cat_command bat
  else
    set cat_command cat
  end

  $cat_command (command -v $argv[1])
end
