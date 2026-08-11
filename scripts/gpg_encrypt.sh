#!/usr/bin/env bash

file="$1"

echo "Choose encryption type:"
echo "1) Symmetric (password)"
echo "2) Asymmetric (public key)"
read -rp "Option: " choice

case "$choice" in
1)
  gpg --symmetric --cipher-algo AES256 "$file"
  ;;

2)
  echo
  echo "Available keys:"
  gpg --list-keys

  echo
  read -rp "Recipient email/key: " recipient

  gpg --encrypt --recipient "$recipient" "$file"
  ;;

*)
  echo "Invalid option"
  exit 1
  ;;
esac

if [ $? -eq 0 ]; then
  echo "GPG operation completed successfully."
  sleep 1
  exit 0
else
  echo "GPG operation failed."
  read -rp "Press Enter to close..."
  exit 1
  fit 1
fi
