{ pkgs }:
let
  application-local-path = "./hyraxService/src/main/resources/application-local.conf";
in pkgs.writeShellApplication {
  name = "hss-init-local";
  runtimeInputs = with pkgs; [ lolcat ];
  text = ''
    if [ $# -eq 1 ]; then
      DB="$1"

      APPLICATION_LOCAL_CONF=$(cat << EOF
include "application.conf"

anyjunk {
  persist.db.writeEndpoint = "hyrax-''${DB}.cluster-cvduhlzmvq4b.eu-west-1.rds.amazonaws.com"
  persist.db.readEndpoint = "hyrax-''${DB}.cluster-ro-cvduhlzmvq4b.eu-west-1.rds.amazonaws.com"
  persist.db.api.password = "PZ9A8bvNmSzvQQZtvbuy4DNfZtFqhbDu"
  application.environment = "staging"
  service {
    email {
      confirmation {
        send = false
        test.recipients = ["test@example.com"]
      }
      onecall.username = "AKIAJ3KDBDZ2DWVGFQHQ"
      onecall.password = "BMLz1plYpBH1AzzaqcEBt5kUL8HJ210TFqLNU63QDALS"
    }
    adflex {
      environment = "live"
      accessKey = "TODO"
      secret = "TODO"
      apgKey = "TODO"
    }
    stripe {
      webhooksecret = "whsec_RKZdPt2R62jnpX3kxgFvJzWjAvAIWImZ"
      environment = "test"
      apikey = "sk_test_bUG2jJMuPEIM4d5ipaCwWmi1008pFhfjdz"
    }
    spanner {
      environment = "test"
      api = "https://testing.hss.com/webservicetest"
      secret = "D2weT4G67kkX"
    }
    freshdesk {
      accessKey = "0VCgVVpzVGQaGsKsX"
    }
    oa.sftppassword = "k4l62g84Mq"
    googlemaps {
      environment = "live"
      apikey = "AIzaSyC10oQ3QXgyCbzb1k70IL4-nStzZX4M9qw"
    }
    s3 {
      environment = "mock"
    }
    portal.host = "http://localhost:3004"
    public.host = "http://localhost:3005"
    supplierPortal.host = "http://localhost:3006"
    location {
      environment = "mock"
      calculator = "TestRouteCalculator"
    }
  }
  gregor {
    processType = email
  }
}

akka.http.server.request-timeout = 1 minute
EOF
)

      if [ -f "${application-local-path}" ]; then
        rm "${application-local-path}"
      fi
      touch "${application-local-path}"
      echo "''${APPLICATION_LOCAL_CONF}" >> "${application-local-path}"

      cat << EOF
Added local conf for database <$DB>
${application-local-path}

Next steps:

cd ./hyrax/src/universal
sudo ./import.sh $JAVA_HOME/lib/security/cacerts
.... or cd ../../..

nix-shell -p awscli2

aws sso login --profile hss-dev

EOF
      echo "Run AWS VPN" | lolcat
      cat << EOF

echo "hyrax/runMain uk.co.anyjunk.hyrax.Boot" | sbt -mem 16384 -Daws.region=eu-west-1 -Daws.profile=hss -Dconfig.resource=application-local.conf
EOF
    else
      echo "Usage: hss-init-local <database-to-connect>"
    fi
  '';
}
