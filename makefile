backend_path = ../sqloj-backend
frontend_path = ../sqloj-frontend
judge_mariadb_path = ../sqloj-judge-mariadb

build: backend database frontend judge_mariadb

backend:
	cd $(backend_path) && ./gradlew bootJar
	cp $(backend_path)/build/libs/sqloj-backend-0.0.1-SNAPSHOT.jar ./src/backend/app.jar
	docker build ./src/backend  -t rogeryoungh/sqloj-backend

frontend:
	cd $(frontend_path) && yarn && yarn build
	cp -r $(frontend_path)/dist ./src/frontend/site
	docker build ./src/frontend  -t rogeryoungh/sqloj-frontend

database:
	cp $(backend_path)/database/init.sql ./src/database/init.sql
	docker build ./src/database -t rogeryoungh/sqloj-database

judge_mariadb:
	cd $(judge_mariadb_path) && ./gradlew bootJar
	cp $(judge_mariadb_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./src/judge-mariadb/backend/app.jar
	cp $(judge_mariadb_path)/database/init.sql ./src/judge-mariadb/database/init.sql
	docker build ./src/judge-mariadb/backend -t rogeryoungh/sqloj-judge-mariadb-backend
	docker build ./src/judge-mariadb/database -t rogeryoungh/sqloj-judge-mariadb-database

test:
	docker-compose up

push:
	docker push rogeryoungh/sqloj-judge-mariadb-backend
	docker push rogeryoungh/sqloj-judge-mariadb-database
