# allstars_reporting

##d Follow the steps to install postgres
### Build the image
```
$allstars_reporting> docker compose build
```

### Start Postgres
```
$allstars_reporting> docker compose up -d
```

### Verify db health
```
docker compose ps
docker compose logs -f postgres   # Ctrl+C to exit
```