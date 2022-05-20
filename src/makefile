backend_path = ../../sqloj-backend
frontend_path = ../../sqloj-frontend
judge_mariadb_path = ../../sqloj-judge-mariadb
judge_h2_path = ../../sqloj-judge-h2

build: backend database frontend judge_h2

backend: database
	cd $(backend_path) && ./gradlew bootJar
	cp $(backend_path)/build/libs/sqloj-backend-0.0.1-SNAPSHOT.jar ./backend/app.jar
	docker build ./backend  -t rogeryoungh/sqloj-backend

frontend:
	cd $(frontend_path) && yarn && yarn build
	rm -rf ./frontend/site
	cp -r $(frontend_path)/dist ./frontend/site
	docker build ./frontend  -t rogeryoungh/sqloj-frontend

database:
	cp $(backend_path)/database/init.sql ./database/init.sql
	docker build ./database -t rogeryoungh/sqloj-database

judge_mariadb:
	cd $(judge_mariadb_path) && ./gradlew bootJar
	cp $(judge_mariadb_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-mariadb/backend/app.jar
	cp $(judge_mariadb_path)/database/init.sql ./judge-mariadb/database/init.sql
	docker build ./judge-mariadb/backend -t rogeryoungh/sqloj-judge-mariadb-backend
	docker build ./judge-mariadb/database -t rogeryoungh/sqloj-judge-mariadb-database

judge_h2:
	cd $(judge_h2_path) && ./gradlew bootJar
	cp $(judge_h2_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-h2/app.jar
	docker build ./judge-h2 -t rogeryoungh/sqloj-judge-h2

test:
	docker-compose up

push:
	docker push rogeryoungh/sqloj-database
	docker push rogeryoungh/sqloj-frontend
	docker push rogeryoungh/sqloj-backend
	docker push rogeryoungh/sqloj-judge-mariadb-backend
	docker push rogeryoungh/sqloj-judge-mariadb-database
	docker push rogeryoungh/sqloj-judge-h2
