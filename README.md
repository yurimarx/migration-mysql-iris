# migration-mysql-iris
Sample repository to show how to migrate from MySQL to InterSystems IRIS

# Credits
1. Article about MySQL into Docker: 
    - https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee
2. Git project created from: 
    - https://github.com/intersystems-community/iris-docker-zpm-usage-template

# to run
1. Build
```
docker-compose build
```
2. Run
```
docker-compose up -d
```
3. Use DBeaver to connect to the databases
    - **Connection to MySQL**: 
        - host: localhost 
        - database: db 
        - port: 3306 
        - username: user 
        - password: password
    - **Connection to IRIS**: 
        - host: localhost 
        - database: user 
        - port: 1972 
        - username: _SYSTEM 
        - password: SYS