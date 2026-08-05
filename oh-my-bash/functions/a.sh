# Navigate Arcadia
a() {
    if [ -d $1 ]; then
        cd $(arc root)/$1
    else
        cd $(arc root)/$(dirname $1);
    fi
}
