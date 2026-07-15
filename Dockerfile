FROM ghcr.io/quarto-dev/quarto:1.8.25

ARG DEBIAN_FRONTEND=noninteractive

# Install a complete, fixed LaTeX runtime from the base distribution. No LaTeX
# packages are downloaded while students render their documents.
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        latexmk \
        lmodern \
        texlive-fonts-recommended \
        texlive-lang-german \
        texlive-latex-extra \
        texlive-luatex \
    && rm -rf /var/lib/apt/lists/*

# Rendering once while building installs the packages used by the template.
WORKDIR /opt/thesis-smoke-test
COPY docker/smoke-test.qmd ./smoke-test.qmd
COPY template/preamble.tex ./preamble.tex
RUN quarto render smoke-test.qmd --to pdf \
    && rm -rf /opt/thesis-smoke-test

COPY --chmod=0755 docker/preview.sh /usr/local/bin/thesis-preview

WORKDIR /work
ENTRYPOINT ["quarto"]
CMD ["render"]
