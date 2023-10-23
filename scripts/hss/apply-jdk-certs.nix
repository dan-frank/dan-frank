{ pkgs }:
let
  certs = [
    "rds-ca-2019"
    "rds-ca-2015"
  ];
in
pkgs.writeShellApplication {
  name = "hss-apply-jdk-certs";
  runtimeInputs = with pkgs; [ wget ];
  text = ''
    set +u

    if [ -z "$JAVA_HOME" ]; then
      echo "JAVA_HOME is not set."
    else
      certFolder=~/Documents/Certificates
      mkdir -p certFolder

      for cert in ${builtins.concatStringsSep " " certs}; do
        certFileName="$cert-root.pem"

        downloadedCert=$(wget -P certFolder "https://s3.amazonaws.com/rds-downloads/$certFileName" 2>&1 | grep -o "$certFolder/$certFileName")

        sudo keytool -trustcacerts -keystore "$JAVA_HOME/lib/security/cacerts" \
          -alias "$cert" \
          -import -file "$downloadedCert" \
          -storepass changeit
      done
    fi
  '';
}
