{ writeShellApplication
, ...
}:
writeShellApplication {
  name = "notflix";
  text = builtins.readFile ./notflix.sh;
}
