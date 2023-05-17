function open_platform --wraps=cd --description 'open neovim in the platform'
    cd && c repos/product-platform-glitchfinder/jobs_service && nv
end
