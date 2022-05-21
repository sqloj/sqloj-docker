backend_path = ../../sqloj-backend
frontend_path = ../../sqloj-frontend
judge_mariadb_path = ../../sqloj-judge-mariadb
judge_h2_path = ../../sqloj-judge-h2

build: backend database frontend judge_mariadb judge_h2

backend: database
	cd $(backend_path) && ./gradlew bootJar
	cp $(backend_path)/build/libs/sqloj-backend-0.0.1-SNAPSHOT.jar ./backend/app.jar
	sudo docker build ./backend  -t rogeryoungh/sqloj-backend

frontend:
	cd $(frontend_path) && yarn && yarn build
	rm -rf ./frontend/site
	cp -r $(frontend_path)/dist ./frontend/site
	sudo docker build ./frontend  -t rogeryoungh/sqloj-frontend

database:
	cp $(backend_path)/database/init.sql ./database/init.sql
	sudo docker build ./database -t rogeryoungh/sqloj-database

judge_mariadb:
	cd $(judge_mariadb_path) && ./gradlew bootJar
	cp $(judge_mariadb_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-mariadb/backend/app.jar
	cp $(judge_mariadb_path)/database/init.sql ./judge-mariadb/database/init.sql
	sudo docker build ./judge-mariadb/backend -t rogeryoungh/sqloj-judge-mariadb-backend
	sudo docker build ./judge-mariadb/database -t rogeryoungh/sqloj-judge-mariadb-database

judge_h2:
	cd $(judge_h2_path) && ./gradlew bootJar
	cp $(judge_h2_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-h2/app.jar
	sudo docker build ./judge-h2 -t rogeryoungh/sqloj-judge-h2

test:
	cd ../compose/test && sudo docker-compose up

push:
	sudo docker push rogeryoungh/sqloj-database
	sudo docker push rogeryoungh/sqloj-frontend
	sudo docker push rogeryoungh/sqloj-backend
	sudo docker push rogeryoungh/sqloj-judge-mariadb-backend
	sudo docker push rogeryoungh/sqloj-judge-mariadb-database
	sudo docker push rogeryoungh/sqloj-judge-h2
