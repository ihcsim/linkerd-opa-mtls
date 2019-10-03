package linkerd.io

import data.sites
import data.apps
import data.containers

deployed_on[[app_name, hostname]] {
  some i
  app_name := apps[i].name
  server := apps[i].servers[_]
  servers := sites[_].servers[_]
  server == servers.name
  hostname := servers.hostname
}

colocated_as_mysql[{app_name, server}] {
  some i, j, k

  # find the mysql server
  apps[i].name == "mysql"
  mysql_server := apps[i].servers[_]

  # find the sites that the mysql server is in
  s := sites[_]
  s.servers[_].name == mysql_server

  # find the other servers on the same site
  # then find the app that is on that site, but isn't mysql
  server := s.servers[j].name
  s.servers[j].name == apps[k].servers[_]
  s.servers[j].name != mysql_server
  app_name = apps[k].name
}

hostnames[app_name] = hostnames {
  app := apps[_]
  app_name := app.name
  hostnames := [hostname | server := app.servers[_]
                           s := sites[_].servers[_]
                           s.name == server
                           hostname := s.hostname]
}

server_hostnames = {server.name: hostnames |
  server := sites[_].servers[_]
  hostnames := [hostname | hostname := server.hostname]
}

prod[app_name] {
  some i, j
  sites[i].name == "prod"
  servers = sites[i].servers

  apps[j].servers[_] == servers[_].name
  app_name = apps[j].name
}

non_prod[app_name] {
  app_name := apps[_].name
  not prod[app_name]
}
