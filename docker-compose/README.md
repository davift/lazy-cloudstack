# Lazy CloudStack

# On Docker with Compose

## ACS Build and Run

```bash
docker compose up --build
```

## ACS Shutdown Persisting DB

```bash
docker compose down
```

## ACS Destroy All Assets

```bash
docker compose down -v
```

## ACS Live Logs

```bash
docker exec -it acs.local tail -n 200 -f /var/log/cloudstack/management/management-server.log
```

