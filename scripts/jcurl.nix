{ pkgs }:
pkgs.writeShellApplication {
  name = "jcurl";
  runtimeInputs = with pkgs; [ curl jq ];
  text = ''
    is_json() {
      echo "$1" | jq . >/dev/null 2>&1
    }

    # Check if the required arguments are provided
    if [ $# -lt 1 ]; then
      echo "Usage: jcurl <request>"
    else
      REQUEST=("''${@:1}")
      RESPONSE=$(curl "''${REQUEST[@]}")
      if is_json "$RESPONSE"; then
        echo "$RESPONSE" | jq
      else
        echo "$RESPONSE"
      fi
    fi
  '';
}
