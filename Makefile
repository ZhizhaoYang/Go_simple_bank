postgres: 
	docker run --name my-postgres -d -p 5555:5432 -e POSTGRES_PASSWORD=123456 -e POSTGRES_USER=root postgres

createdb:
	docker exec -it my-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose up 1
	  
migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose down
	
migratedown1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5555/simple_bank?sslmode=disable" -verbose down 1
	
sqlc:
	sqlc generate
	
test: 
	go test -v -cover ./...
	
server:
	go run main.go
	
mock: 
	mockgen -package mockdb -destination db/mock/store.go github.com/techschool/simplebank/db/sqlc Store
	
.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock
	
	