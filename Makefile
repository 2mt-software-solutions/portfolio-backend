install: ## Install
	@docker-compose exec php composer install --optimize-autoloader
	@docker-compose exec php composer dump-autoload
	@$(MAKE) cache

enter: ## Enter php container
	@docker-compose exec php bash

start: ## Start Containers
	@docker-compose up -d

stop: ## Stop Containers
	@docker-compose stop

recreate: ## recreate containers
	@$(MAKE) stop
	@docker-compose rm -f
	@docker-compose build
	@$(MAKE) start
