postgres: 
	docker run --name my-postgres -d -p 5555:5432 -e POSTGRES_PASSWORD=123456 -e POSTGRES_USER=root postgres

createdb:
	docker exec -it my-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose up
	 
migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose down
	
sqlc:
	sqlc generate
	
test: 
	go test -v -cover ./...
	
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
	
	