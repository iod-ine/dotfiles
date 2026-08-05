function a
    if [ -d $argv[1] ]
        cd (arc root)/$argv[1]
    else
        cd (arc root)/(dirname $argv[1])
    end
end
