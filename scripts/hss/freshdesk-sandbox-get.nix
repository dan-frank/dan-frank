{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-freshdesk-sandbox-get";
  runtimeInputs = with pkgs; [ lolcat ];
  text = ''
    if [ $# -eq 1 ]; then
      FRESHDESK_REFERENCE="$1"

      jcurl  --location "https://hsshiresandbox.freshdesk.com/api/v2/tickets/''${FRESHDESK_REFERENCE}" \
            --header 'Authorization: Basic MFZDZ1ZWcHpWR1FhR3NLc1g6WA==' \
            --header 'Cookie: _x_m=x_c; _x_w=euc'

      echo "Ensure reference is not **1110779** and that any refernce does not exist in the customer_freshdesk_references table as these are fallbacks." | lolcat
    else
      echo "Usage: hss-freshdesk-sandbox-get <freshdesk-reference>"
    fi
  '';
}
