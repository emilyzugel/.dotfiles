#!/bin/bash

# Fetch Bitcoin price in USD from CoinGecko API
price=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd')

# Format the price with commas
formatted_price=$(printf "%.0f" "$price")  # Remove decimal points for simplicity

# Check if price is greater than or equal to 1,000 and format it with a 'k' suffix
if [ "$formatted_price" -ge 1000000 ]; then
    # Format the price to millions (e.g., 1.2M)
    formatted_price=$(echo "scale=1; $price / 1000000" | bc)
    formatted_price=$(printf "%.1fM" "$formatted_price")
elif [ "$formatted_price" -ge 1000 ]; then
    # Format the price to thousands (e.g., 120k)
    formatted_price=$(echo "scale=0; $price / 1000" | bc)
    formatted_price=$(printf "%dk" "$formatted_price")
fi

# Print the formatted price in plain text
echo "₿ $formatted_price"

