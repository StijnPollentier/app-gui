/* 
        !!! THIS IS ONLY NEEDED FOR THE DOCKER IMAGE !!! 
        Actual database should have proper passwords...
 */
--- set the password to a proper password when creating an actual DB ---
ALTER role daltix WITH PASSWORD 'postgres';
ALTER role dashboard WITH PASSWORD 'postgres';
