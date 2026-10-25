\# Spring Security 專案



使用 Spring Boot、Spring Security、JWT、Vue 2、MySQL、Redis 建置的前後端分離專案，並使用 Docker Compose 部署。



\## 一、技術架構

| 		類別 		| 				技術 				|
|-------------------|-----------------------------------|
| 後端 				| Java、Spring Boot、Spring Security	|
| 身分驗證 			| JWT 								|
| 前端 				| Vue 2、Element UI 					|
| 資料庫 			| MySQL 8.0 						|
| 快取／Token 儲存 	| Redis 							|
| ORM 				| MyBatis-Plus 						|
| 容器化 			| Docker、Docker Compose 			|
| 建置工具 			| Maven 							|


\## 二、系統架構

\- Frontend：Vue 2 前端，使用 Nginx 提供網頁服務。
\- Backend：Spring Boot REST API。
\- MySQL：儲存使用者、角色、選單及權限等資料。
\- Redis：儲存登入相關資訊。
\- Docker Compose：管理所有服務與容器間的網路。


\## 三、服務連接埠

| 服務 	| 容器名稱 			  |	 本機連接埠 	|
|-------|---------------------|-------------|
| 前端 	| springboot-frontend | 	8080 	|
| 後端	| springboot-backend  | 	8081	|
| MySQL	| spring-mysql 		  | 	3306 	|
| Redis | spring-redis 		  | 	6379 	|


前端網址：http://localhost:8080

後端網址：http://localhost:8081

\## 四、環境需求

請先安裝：

\- Docker Desktop

\- Docker Compose（Docker Desktop 已包含 Compose Plugin）

啟動 Docker Desktop，確認 Docker Engine 正常運作。


\## 五、啟動專案

1. 下載或複製本專案。
2. 開啟終端機，切換至 `docker-compose.yml` 所在目錄。
3. 於上方資料路徑位置輸入powershell並輸入下方命令(複製環境設定檔並啟動專案)：

   ```powershell
   Copy-Item .env.example .env
   docker compose up -d
   ```

4. 確認容器狀態：

   ```powershell
   docker compose ps
   ```

5. 查看後端日誌：

   ```powershell
   docker logs --tail 100 springboot-backend
   ```

啟動完成後，開啟 http://localhost:8080 使用系統。



\## 六、停止專案

停止並移除 Compose 建立的容器與網路：

```bash

docker compose down

```

此指令不會刪除 MySQL 的持久化 Volume，資料庫資料會保留。


再次啟動時執行：

```bash

docker compose up -d

```

\## 七、資料庫與資料持久化


MySQL 使用 Docker Named Volume 儲存資料：


`spring-security-docker\_mysql-data`


資料庫資料儲存在 Volume 中，即使執行 `docker compose down` 移除容器，資料仍會保留。



本專案的 `sql/` 目錄掛載至 MySQL 初始化目錄：


`/docker-entrypoint-initdb.d`

MySQL 官方映像檔只會在資料目錄尚未初始化時執行這些初始化腳本。既有 Volume 不會因為新增或修改 SQL 檔案而自動重新初始化。


\## 八、資料庫備份


專案中的 `mybatis-backup.sql` 是資料庫備份檔。

若要重新產生備份，可在容器運行時執行：

```bash

docker exec spring-mysql mysqldump -uroot -p123456 --default-character-set=utf8mb4 --databases mybatis --result-file=/tmp/mybatis-backup.sql

docker cp spring-mysql:/tmp/mybatis-backup.sql ./mybatis-backup.sql

```


請依實際環境調整資料庫帳號與密碼。


\## 九、重要注意事項

1\. 請確認 Docker Desktop 已啟動。

2\. 本機的 8080、8081、3306、6379 連接埠不可被其他程式占用。

3\. `docker-compose.yml` 中的資料庫密碼僅供本機開發測試，不建議直接用於正式環境。

4\. 請勿隨意執行 `docker compose down -v`，因為 `-v` 會刪除 Compose 管理的 Volume，可能導致資料庫資料遺失。

5\. `mybatis-backup.sql` 包含資料庫內容，分享前請確認沒有個人資料、帳號或其他敏感資訊。

6\. 若要讓其他人使用，請確保 Docker Hub 上的映像檔可供對方下載，並提供必要的資料庫初始化腳本。



\## 十、重新下載映像檔



如需手動下載映像檔，可執行：

```bash

docker pull masteryuanhao/spring-security-backend:1.1

docker pull masteryuanhao/spring-security-frontend:1.1

```

MySQL 與 Redis 映像檔會由 Docker Compose 依設定自動下載。

\## 十一、重新建立容器


```bash

docker compose up -d

```

若需要更新後端或前端映像檔，請先下載新版映像檔，再重新建立容器。
