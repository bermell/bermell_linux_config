function platform --wraps=cd --description 'does docker compose up or down for the platform'
    set -l platform_directory /home/mattias/repos/platform/docker/platform-local
    set -l profiles --profile jobs_service --profile build
    set -l auth_profile --profile authentication
    set -l no_auth_profile --profile no-authentication
    set -l all_profiles $profiles $auth_profile $no_auth_profile


    set -l usage "Usage: platform [up|up-auth|down|watch]"


    #if there are no arguments, exit here
    if test -z "$argv"
        cd $platform_directory
        cd ../../
        return
    end


    cd $platform_directory

    if test "$argv[1]" = up
        set -f compose_args $profiles $no_auth_profile up --force-recreate --build -d
    else if test "$argv[1]" = up-auth
        set -f compose_args $profiles $auth_profile up --force-recreate --build -d
    else if test "$argv[1]" = down
        set -f compose_args $all_profiles down --remove-orphans
    else if test "$argv[1]" = watch
        set -f compose_args $profiles $no_auth_profile watch
    else if test "$argv[1]" = watch-auth
        set -f compose_args $profiles $auth_profile watch
    else
        echo 'unknown command: ' $argv[1]
        echo $usage
        return
    end
    echo "docker compose $compose_args"
    docker compose $compose_args
end
