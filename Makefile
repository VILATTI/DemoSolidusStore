PORT ?= 3020
DB_CONTAINER := demo-solidus-db
DB_PORT := 5434

.PHONY: setup db run stop reset

setup:
	brew list shared-mime-info >/dev/null 2>&1 || brew install shared-mime-info
	brew list imagemagick >/dev/null 2>&1 || brew install imagemagick
	bundle install
	$(MAKE) db
	bin/rails db:create db:migrate

db:
	@docker start $(DB_CONTAINER) 2>/dev/null || \
		docker run -d --name $(DB_CONTAINER) -e POSTGRES_PASSWORD=postgres -p $(DB_PORT):5432 postgres:16
	@until docker exec $(DB_CONTAINER) pg_isready -U postgres >/dev/null 2>&1; do sleep 1; done

run: db
	PORT=$(PORT) bin/dev

stop:
	docker stop $(DB_CONTAINER)

reset:
	bin/rails db:drop db:create db:migrate
	bin/rails generate solidus:install --auto-accept --sample --admin-email=admin@example.com --admin-password=test1234
