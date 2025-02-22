#!/bin/bash

# 🌍 Fetch Netlify environment variables
echo "🌍 Fetching Netlify environment variables..."
if [[ -n "$NETLIFY_API_TOKEN" && -n "$NETLIFY_SITE_ID" ]]; then
    curl -s -H "Authorization: Bearer $NETLIFY_API_TOKEN" \
         https://api.netlify.com/api/v1/sites/$NETLIFY_SITE_ID/env | jq -r \
         '.[] | select(.values[0].value != null) | "\(.key)=\(.values[0].value)"' | sort -u > .env
    echo "✅ Netlify environment variables fetched"
else
    echo "⚠️ Netlify API Token or Site ID is missing! Skipping."
fi