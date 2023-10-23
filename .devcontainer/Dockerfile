FROM mcr.microsoft.com/azure-functions/powershell:4-powershell7.2-core-tools

# copy scripts and make bash files executable
# use copy instead of add, it's safer apparently
COPY scripts/startup.ps1 /tmp/
RUN chmod +x /tmp/*.ps1

# convert CRLF to LF in case Windows or VS Code changed it
RUN find . -type f \( -name "*.sql" -o -name "*.env" -o -name "*.sh" -o -name "*.ps1" \) -exec sed -i 's/\r$//' {} \;

# some people add github functionality here but I found it to be super slow
# to compile for the first time so I moved adding what I wanted here
RUN set -ex; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
    ca-certificates curl powershell-lts git; \
    rm -rf /var/lib/apt/lists/*