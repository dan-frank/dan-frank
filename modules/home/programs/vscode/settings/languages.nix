{ pkgs, ... }:
{
  "java.semanticHighlighting.enabled" = true;
  "metals.javaHome" = "${pkgs.jdk}";
  "php.validate.executablePath" = "${pkgs.php81}/bin/php";
}
