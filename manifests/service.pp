class tcpwrappers::service inherits tcpwrappers {

  #
  validate_bool($tcpwrappers::manage_docker_service)
  validate_bool($tcpwrappers::manage_service)
  validate_bool($tcpwrappers::service_enable)

  validate_re($tcpwrappers::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${tcpwrappers::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $tcpwrappers::manage_docker_service)
  {
    if($tcpwrappers::manage_service)
    {
      service { $tcpwrappers::params::service_name:
        ensure => $tcpwrappers::service_ensure,
        enable => $tcpwrappers::service_enable,
      }
    }
  }
}
