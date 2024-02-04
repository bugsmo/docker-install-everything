log_level = "error"
data_dir = "/consul/data"
client_addr = "0.0.0.0"
ui_config{
  enabled = true
}
ports = {
  grpc = -1
  https = -1
  dns = -1
  grpc_tls = -1
  serf_wan = -1
}
peering {
  enabled = false
}
connect {
  enabled = false
}
server = true
bootstrap_expect=1
acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
  tokens {
    // 与 docker-compose.yml 中的 consul_token 一致，使用 uuidgen 命令生成
    initial_management = "55d0c523-1230-40bf-8f3b-3723a14429e0"
    agent = "55d0c523-1230-40bf-8f3b-3723a14429e0"
  }
}