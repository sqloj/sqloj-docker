backend_path = ../../sqloj-backend
frontend_path = ../../sqloj-frontend
judge_mariadb_path = ../../sqloj-judge-mariadb
judge_h2_path = ../../sqloj-judge-h2
judge_sqlserver_path = ../../sqloj-judge-sqlserver
juege_redis_path = ../../sqloj-judge-redis

build: backend database frontend judge_mariadb judge_h2 judge_sqlserver judge_redis

backend: database
	cd $(backend_path) && ./gradlew bootJar
	cp $(backend_path)/build/libs/sqloj-backend-0.0.1-SNAPSHOT.jar ./sqloj-backend/app.jar
	sudo docker build ./sqloj-backend  -t clumsysysy/sqloj-backend

frontend:
	cd $(frontend_path) && yarn && yarn build
	rm -rf ./sqloj-frontend/site
	cp -r $(frontend_path)/dist ./sqloj-frontend/site
	sudo docker build ./sqloj-frontend  -t clumsysysy/sqloj-frontend

database:
	cp $(backend_path)/database/init.sql ./database/init.sql
	sudo docker build ./database -t clumsysysy/sqloj-database

judge_mariadb:
	cd $(judge_mariadb_path) && ./gradlew bootJar
	cp $(judge_mariadb_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-mariadb/backend/app.jar
	cp $(judge_mariadb_path)/database/init.sql ./judge-mariadb/database/init.sql
	sudo docker build ./judge-mariadb/backend -t clumsysysy/sqloj-judge-mariadb-backend
	sudo docker build ./judge-mariadb/database -t clumsysysy/sqloj-judge-mariadb-database

judge_h2:
	cd $(judge_h2_path) && ./gradlew bootJar
	cp $(judge_h2_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-h2/app.jar
	sudo docker build ./judge-h2 -t clumsysysy/sqloj-judge-h2

judge_sqlserver:
	cd $(judge_sqlserver_path) && ./gradlew bootJar
	cp $(judge_sqlserver_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-sqlserver/backend/app.jar
	sudo docker build ./judge-sqlserver/backend -t clumsysysy/sqloj-judge-sqlserver-backend

judge_redis:
	cd $(juege_redis_path) && ./gradlew bootJar
	cp $(juege_redis_path)/build/libs/sqloj-judge-0.0.1-SNAPSHOT.jar ./judge-redis/backend/app.jar
	cp $(juege_redis_path)/database/redis.conf ./judge-redis/database/redis.conf
	sudo docker build ./judge-redis/backend -t clumsysysy/sqloj-judge-redis-backend
	sudo docker build ./judge-redis/database -t clumsysysy/sqloj-judge-redis-database

test:
	cd ../compose/test && sudo docker-compose up

push:
	docker push clumsysysy/sqloj-database
	docker push clumsysysy/sqloj-frontend
	docker push clumsysysy/sqloj-backend
	docker push clumsysysy/sqloj-judge-mariadb-backend
	docker push clumsysysy/sqloj-judge-mariadb-database
	docker push clumsysysy/sqloj-judge-h2
	docker push clumsysysy/sqloj-judge-sqlserver-backend
	docker push clumsysysy/sqloj-judge-redis-backend
	docker push clumsysysy/sqloj-judge-redis-database
