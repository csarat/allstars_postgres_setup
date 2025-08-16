# syntax=docker/dockerfile:1
FROM postgres:latest

# Optional: set locale and timezone (keeps logs consistent)
ENV LANG=en_US.utf8 \
    LC_ALL=en_US.utf8 \
    TZ=America/Chicago

# Install extra packages / extensions here if you need them.
# Example below shows curl & vim; comment these out if not needed.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      tzdata curl vim && \
    rm -rf /var/lib/apt/lists/*

# Copy any SQL or shell scripts into the standard init directory.
# Files ending with .sql, .sql.gz, or .sh will run on first container start,
# after the database cluster is created.
# Create ./initdb/ next to this Dockerfile and place your scripts there.
# COPY initdb/ /docker-entrypoint-initdb.d/

# Optional: custom config. If you add postgres.conf or pg_hba.conf to ./config,
# they’ll be copied and included via POSTGRES_CONFIG_INCLUDE.
# (You can also mount them via volumes instead of baking into the image.)
# COPY config/ /etc/postgresql/custom/
# ENV POSTGRES_CONFIG_INCLUDE=/etc/postgresql/custom/postgresql.conf

# Default exposed port (already exposed by base image, but explicit is fine)
EXPOSE 5432
