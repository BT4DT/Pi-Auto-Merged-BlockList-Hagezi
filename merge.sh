#!/bin/bash

rm -f raw.txt merged_clean.txt final.txt whitelist.txt

# ===== list =====
urls=(
# =========== Hagezi- Multi PRO - Extended protection
# ===  🟢 Domains Subdomains
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/pro.txt"
# ===  🟢 Hosts
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/hosts/pro.txt"
# ===  🔴 Hosts Compressed
# "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/hosts/pro-compressed.txt"
# ===  🟢 Adblock
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt"
# ===  🟢 DNSMasq
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/dnsmasq/pro.txt"
# ===  🟢 Wildcard Asterisk
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
# ===  🟢 Wildcard Domains
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro-onlydomains.txt"
# ===  🔴 RPZ
# "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/rpz/pro.txt"
# =========== END
)

# ===== download =====
for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
  echo -e "\n" >> raw.txt
done

# ===== clean basic =====
grep -vE '^\s*$' raw.txt | \
grep -vE 'localhost|localdomain|broadcasthost' > cleaned.txt

# ===== remove duplicate =====
sort -u cleaned.txt > merged_clean.txt

# ===== whitelist =====
cat <<EOF > whitelist.txt
# ==== WHITELIST ====
# remove # to enable
dns.google.com
cloudflare.com
cloudflare-dns.com
gstatic.com
dnsforge.de
mymax.top
dnsz.in
plusiptv.dnsz.in
tvdns.top
plusiptv.tvdns.top
media-shop.top
filimo.com
namava.ir
filmnet.ir
snapp.site
aptel.ir
soft98.ir
github.com
tailscale.com
zerotier.com
goodcloud.xyz
astrowarp.net
youtubei.googleapis.com
EOF

# ===== final =====
cat whitelist.txt merged_clean.txt > final.txt

mv final.txt merged.txt

# ===== clean =====
rm raw.txt cleaned.txt merged_clean.txt whitelist.txt
