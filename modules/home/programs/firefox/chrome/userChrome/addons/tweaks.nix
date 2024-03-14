{ config, ... }:
''
  /**
   * Custom CSS Changes
   */

  /* Font */
  * {
    /* TODO: Pass nix font */
    font-family: "${config.fontProfiles.regular.family}", sans-serif !important;
    font-size: 14px !important;
  }

  /* Container bar */
  .tab-context-line {
    display: none;
  }
''
