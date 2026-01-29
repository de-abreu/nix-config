{config, ...}: {
  programs.fish.shellInit = let
    secrets = config.sops.secrets;
  in
    # fish
    ''
      export DEEPSEEK_API_KEY=(cat ${secrets."api-keys/deepseek".path})
      export TAVILY_API_KEY=(cat ${secrets."api-keys/tavily".path})
    '';
}
