# install dependencies and clear cache
install:
	@docker-compose exec php composer install --optimize-autoloader
	@docker-compose exec php composer dump-autoload
	@$(MAKE) cache

# enter bash within the php container
enter:
	@docker-compose exec php bash

# start all containers
start:
	@docker-compose up -d

# stop all containers
stop: ## Stop Containers
	@docker-compose stop

# start from scratch, delete & recreate all containers
recreate:
	@just stop
	@docker-compose rm -f
	@docker-compose build
	@just start

# clear the cache
cc:
	@docker-compose exec php bin/console cache:clear

# Run static code analysis
analyse:
	@docker-compose exec php vendor/bin/phpstan analyse --memory-limit 1G --xdebug src
	@docker-compose exec php vendor/bin/phpmd src text phpmd.ruleset.xml

# Run testsuites
test:
	@docker-compose exec php php vendor/bin/phpunit --log-junit test-results/phpunit.xml
	@sed -i "s%/var/www/html/%`pwd`/%" test-results/phpunit.xml
	@docker-compose exec php php vendor/bin/behat

# Run testsuite with coverage reporting enabled
coverage:
	@docker-compose exec -e XDEBUG_MODE=coverage php php ./vendor/bin/phpunit --coverage-clover ./test-results/coverage/xml/phpunit.xml --log-junit est-results/phpunit.xml
	@sed -i "s%/var/www/html/%`pwd`/%" test-results/coverage/xml/phpunit.xml
	@docker-compose exec -e XDEBUG_MODE=coverage php vendor/bin/behat --format=junit --out=test-results --format=pretty --out=std -p coverage
	@sed -i "s%/var/www/html/%`pwd`/%" test-results/coverage/xml/behat.xml

# Run php-cs-fixer
fix:
	@docker-compose exec php vendor/bin/php-cs-fixer fix

