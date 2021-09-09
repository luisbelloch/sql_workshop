CONTAINER_NAME ?= sql_workshop
WORKDIR ?= /opt/sql_workshop
MYSQL_EXEC := docker exec -w $(WORKDIR) -it $(CONTAINER_NAME) $(MYSQL_CMD)

.PHONY: shell
shell:
	docker exec -w $(WORKDIR) -it $(CONTAINER_NAME) mysql -u root -ppassword playground

.PHONY: up
up:
	docker run --name $(CONTAINER_NAME) \
		--env-file .env \
		-p 3306:3306 \
		-d -ti \
		-v $(PWD):$(WORKDIR) \
		mysql:8.0.17 --default-authentication-plugin=mysql_native_password --local-infile

.PHONY: down
down:
	docker rm -f $(CONTAINER_NAME)
