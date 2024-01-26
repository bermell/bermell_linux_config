function platform --wraps=cd --description 'does docker compose up or down for the platform'
    set -l platform_directory /home/mattias/repos/product-platform-glitchfinder/docker/platform-local
    cd $platform_directory

    if test "$argv[1]" = "up"
        # set -f _extra_arg "" 
        # if test (count $argv) -gt 1
        #   set -f _extra_arg $argv[2]
        # end

        docker compose --profile jobs_service --profile no-authentication  up --force-recreate --build -d $_extra_arg
    else if test "$argv[1]" = "down"
        docker compose down --remove-orphans
    else
        echo 'unknown command'
    end
end
