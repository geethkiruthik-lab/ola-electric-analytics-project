CREATE TABLE social_media_posts (
    post_id VARCHAR(50) PRIMARY KEY,
    platform VARCHAR(50),
    user_handle_hash VARCHAR(100),
    text TEXT,
    likes INTEGER,
    shares INTEGER,
    comments INTEGER,
    is_verified BOOLEAN,
    location_tag VARCHAR(100),
    posted_date DATE,
    total_engagement INTEGER
        GENERATED ALWAYS AS (
            COALESCE(likes, 0) + COALESCE(shares, 0) + COALESCE(comments, 0)
        ) STORED
);