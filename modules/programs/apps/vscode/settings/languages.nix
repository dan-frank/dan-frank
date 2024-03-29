{ pkgs, ... }:
{
  "java.semanticHighlighting.enabled" = true;
  "metals.javaHome" = "${pkgs.jdk17}";
  "php.validate.executablePath" = "${pkgs.php83}/bin/php";
}
