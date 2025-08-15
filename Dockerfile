# docker build --network=host . -f Dockerfile -t debug
# docker run --network=host --gpus=all --rm -it debug

# An already existing image to debug in:
FROM nvcr.io/nvidia/pytorch:24.10-py3

ENV PATH="/root/.local/bin:${PATH}"

RUN git clone https://github.com/iod-ine/dotfiles ~/.dotfiles && \
    mkdir -p ~/.config && \
    ln -s ~/.dotfiles/nvim ~/.config/nvim

RUN \
    mkdir -p ~/.local/bin && \
    wget -O ~/.local/bin/nvim.tgz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    tar xf ~/.local/bin/nvim.tgz -C ~/.local/bin && \
    ln -s ~/.local/bin/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim && \
    mkdir -p /tmp/fzf && \
    curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
     | jq '.assets[] | select(.name | test("linux_amd64.tar.gz$$")) | .browser_download_url' \
     | xargs wget -O /tmp/fzf.tgz && \
    tar xf /tmp/fzf.tgz -C ~/.local/bin && \
    mkdir -p /tmp/ripgrep && \
    curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
    | jq '.assets[] | select(.name | test("x86_64.+linux.+tar.gz$$")) | .browser_download_url' \
    | xargs wget -O /tmp/ripgrep/rg.tgz && \
    tar --strip-components=1 -xf /tmp/ripgrep/rg.tgz -C /tmp/ripgrep && \
    mv /tmp/ripgrep/rg ~/.local/bin && \
    nvim --headless '+Lazy! sync' +qa && \
    curl -LsSf https://astral.sh/uv/install.sh | sh
