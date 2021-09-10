CONTAINER_NAME ?= sql_workshop
WORKDIR ?= /opt/sql_workshop
MYSQL_EXEC := docker exec -w $(WORKDIR) -it $(CONTAINER_NAME)
MYSQL_CMD := $(MYSQL_EXEC) mysql --login-path=$(CONTAINER_NAME) playground

.PHONY: scratch
scratch:
	$(MYSQL_CMD) -e "source $(WORKDIR)/scratch.sql;"

.PHONY: schema
schema:
	$(MYSQL_CMD) -e "source $(WORKDIR)/schema.sql;"

.PHONY: credentials
credentials:
	$(MYSQL_EXEC) mysql_config_editor set --login-path=$(CONTAINER_NAME) --host=localhost --user=root --password

.PHONY: drop
drop:
	$(MYSQL_CMD) -e "source $(WORKDIR)/drop.sql;"

.PHONY: shell
shell:
	$(MYSQL_CMD)

.PHONY: up
up:
	docker run --name $(CONTAINER_NAME) \
		--env-file .env \
		-p 3306:3306 \
		-d -ti \
		-v $(PWD):$(WORKDIR) \
		-v $(PWD)/.mylogin.cnf:/root/.mylogin.cnf \
		mysql:8.0.17 --default-authentication-plugin=mysql_native_password --local-infile

.PHONY: down
down:
	docker rm -f $(CONTAINER_NAME)

.PHONY: logs
logs:
	docker logs $(CONTAINER_NAME)

.PHONY: clean
clean:
	rm -rf data/*.csv

.PHONY: generate_data
generate_data: data/portal.csv data/tag.csv data/matrix.csv

data/%.csv:
	cd data; bundle exec ruby seed.rb $(basename $(notdir $@)) > $(notdir $@)

PHONY: seed
seed: generate_data
	time $(MYSQL_CMD) --local-infile -e "source $(WORKDIR)/data/load.sql;"

.PHONY: slides
slides:
	docker run -v $(PWD)/slides.md:/src/slides.md -it jess/mdp -f slides.md
