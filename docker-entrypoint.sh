#!/bin/bash
# docker-entrypoint.sh

# Create required directories if they don't exist
mkdir -p /var/www/html/backups
chmod 777 /var/www/html/backups

# Create data files with proper permissions
touch /var/www/html/movies.csv
touch /var/www/html/users.json
touch /var/www/html/bot_stats.json
touch /var/www/html/movie_requests.json
touch /var/www/html/bot_activity.log

# Set permissions for data files
chmod 666 /var/www/html/*.csv /var/www/html/*.json /var/www/html/*.log

# Initialize CSV with headers if empty
if [ ! -s /var/www/html/movies.csv ]; then
    echo "movie_name,message_id,channel_id" > /var/www/html/movies.csv
fi

# Initialize JSON files if empty
if [ ! -s /var/www/html/users.json ]; then
    echo '{"users": {}, "total_requests": 0, "message_logs": [], "daily_stats": {}}' > /var/www/html/users.json
fi

if [ ! -s /var/www/html/bot_stats.json ]; then
    echo '{"total_movies": 0, "total_users": 0, "total_searches": 0, "total_downloads": 0, "successful_searches": 0, "failed_searches": 0, "daily_activity": {}, "last_updated": "'$(date -Iseconds)'"}' > /var/www/html/bot_stats.json
fi

if [ ! -s /var/www/html/movie_requests.json ]; then
    echo '{"requests": [], "pending_approval": [], "completed_requests": [], "user_request_count": {}}' > /var/www/html/movie_requests.json
fi

# Start Apache
exec apache2-foreground