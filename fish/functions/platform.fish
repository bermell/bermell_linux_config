function platform --wraps=cd --description 'does docker compose up or down for the platform'
    set -l platform_directory /home/mattias/repos/product-platform-glitchfinder/docker/platform-local
    set -l profiles --profile jobs_service --profile no-authentication

    cd $platform_directory

    if test "$argv[1]" = up
        docker compose $profiles up --force-recreate --build -d
    else if test "$argv[1]" = down
        docker compose $profiles down --remove-orphans
    else
        echo 'unknown command'
    end
end
