# DemoSolidusStore

A stock Solidus 4.7 store with sample data and Stripe test-mode payments.

## Requirements

- macOS with Homebrew
- Ruby 4.x (see `.ruby-version`), Node 20+
- Docker (Postgres runs in a container on port 5434)

## First run

```bash
make setup
bin/rails generate solidus:install --auto-accept --sample \
  --admin-email=admin@example.com --admin-password=test1234
make run
```

## Every day

```bash
make run        # starts Postgres if needed, then the app on http://localhost:3020
make stop       # stops Postgres
make reset      # drops the DB and reinstalls Solidus with sample data
```

Override the port with `make run PORT=4000`.

## URLs

| What        | URL                                   |
|-------------|---------------------------------------|
| Storefront  | http://localhost:3020                 |
| Admin       | http://localhost:3020/admin           |
| API         | http://localhost:3020/api/products    |

Admin login: `admin@example.com` / `test1234`.

## Notes

- `app/assets/config/manifest.js` exists only because Solidus admin still needs sprockets on Rails 8.
- Product images go through ImageMagick (`variant_processor = :mini_magick`),
  since Solidus describes image sizes in ImageMagick geometry. `saver` is added to
  Rails' allowed image-processing methods for the same reason.
